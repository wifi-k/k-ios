//
//  SXNetBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetBroadbandController.h"
#import "SXDynamicController.h"
#import "SXNetBroadbandHeaderView.h"
#import "SXAddXiaokiNetTool.h"
#import "NSString+Hash.h"
#import "SXMineNetTool.h"

@interface SXNetBroadbandController ()
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
    
    self.navigationItem.title = @"宽带拨号上网";
    
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
    
    self.headerView.frame = self.view.bounds;
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
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    static NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"网络状态正常");
        //页面跳转
        SXDynamicController *dynamicVC = [[SXDynamicController alloc] init];
        [weakSelf.navigationController pushViewController:dynamicVC animated:YES];
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
    [MBProgressHUD showWhiteLoadingWithMessage:@"绑定中..." toView:SXKeyWindow];
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    [SXMineNetTool userNodeBindParams:shareInfo.modelId Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        
        //通知绑定成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //提示
            [MBProgressHUD showSuccessWithMessage:@"绑定成功!" toView:SXKeyWindow];
        });
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
    }];
}

@end
