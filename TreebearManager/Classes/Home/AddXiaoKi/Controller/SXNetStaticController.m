//
//  SXNetStaticController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetStaticController.h"
#import "SXNetStaticHeaderView.h"
#import "SXNetOptionHeaderView.h"
#import "SXAddXiaokiNetTool.h"
#import "SXMineNetTool.h"
#import "SXNotificationCenterTool.h"
#import "SXRootTool.h"

@interface SXNetStaticController ()
///头部视图
//@property (nonatomic, weak) SXNetOptionHeaderView *navigationView;

///头部视图
@property (nonatomic, weak) SXNetStaticHeaderView *headerView;
@end

@implementation SXNetStaticController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"静态IP上网";
    
    //4.添加底部视图
//    UIView *headerBgView = [[UIView alloc] init];
//    headerBgView.backgroundColor = SXColorWhite;
//    headerBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
//    self.tableView.tableHeaderView = headerBgView;
//
//    SXNetOptionHeaderView *navigationView = [SXNetOptionHeaderView headerView];
//    navigationView.frame = self.tableView.tableHeaderView.bounds;
//    navigationView.title = @"静态IP上网";
//    [self.tableView.tableHeaderView addSubview:navigationView];
//    self.navigationView = navigationView;
    
    WS(weakSelf);
    SXNetStaticHeaderView *headerView = [SXNetStaticHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf jumpToNetDynamicVC];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

#pragma mark -跳转动态设置页面-
- (void)jumpToNetDynamicVC{
    WS(weakSelf);
    SXNetStaticParam *param = [SXNetStaticParam param];
    param.ip = self.headerView.param.ip;
    param.netmask = self.headerView.param.netmask;
    param.gateway = self.headerView.param.gateway;
    param.dns1 = self.headerView.param.dns1;
    param.dns2 = self.headerView.param.dns2;
    [MBProgressHUD showWhiteLoadingWithMessage:nil toView:self.view];
    [SXAddXiaokiNetTool staticSettingWithDataWithParams:param.mj_keyValues Success:^{
        DLog(@"静态IP设置成功");
        //跳转
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
