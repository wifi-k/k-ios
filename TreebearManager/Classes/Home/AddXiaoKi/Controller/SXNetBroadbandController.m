//
//  SXNetBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetBroadbandController.h"
#import "SXNetBroadbandHeaderView.h"
#import "SXNetOptionHeaderView.h"
#import "SXAddXiaokiNetTool.h"
#import "NSString+Hash.h"
#import "SXMineNetTool.h"
#import "SXNotificationCenterTool.h"
#import "SXRootTool.h"

@interface SXNetBroadbandController ()
///头部视图
@property (nonatomic, weak) SXNetOptionHeaderView *navigationView;

///头部视图
@property (nonatomic, weak) SXNetBroadbandHeaderView *headerView;
@end

@implementation SXNetBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    //4.添加底部视图
    SXNetOptionHeaderView *navigationView = [SXNetOptionHeaderView headerView];
    navigationView.title = @"宽带拨号上网";
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
    
    WS(weakSelf);
    SXNetBroadbandHeaderView *headerView = [SXNetBroadbandHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf jumpToNetDynamicVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.navigationView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

#pragma mark -跳转动态设置页面-
- (void)jumpToNetDynamicVC{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = self.headerView.param.name;
    param.passwd = self.headerView.param.passwd;
    [MBProgressHUD showWhiteLoadingWithMessage:nil toView:self.view];
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        DLog(@"宽带拨号成功");
        [weakSelf networkStatusData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    static NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"网络状态正常");
        //获取节点信息
        [weakSelf userNodeBindData];
    } failure:^(NSError * _Nonnull error) {
        ++count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count%5 != 0) {
                [weakSelf networkStatusData];
            } else{
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"请检查配置参数，然后重试!" toView:weakSelf.view];
                });
            }
        });
    }];
}

#pragma mark -节点绑定-
- (void)userNodeBindData{
    //更新wan信息
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    [SXMineNetTool userNodeBindParams:shareInfo.modelId Success:^{
        DLog(@"绑定成功!");
        //切换根控
        [SXRootTool changeToMainHomeVC];
        //通知绑定成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SXNotificationCenterTool postNotificationBindXiaoKiSuccess];
        });
    } failure:^(NSError *error) {
        DLog("error:%@",error.userInfo);
    }];
}

@end
