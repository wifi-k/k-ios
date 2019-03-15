//
//  SXNetStaticController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetStaticController.h"
#import "SXDynamicController.h"
#import "SXNetStaticHeaderView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXNetStaticController ()
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
    
    self.navigationItem.title = @"静态IP上网";
    
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
    [SXAddXiaokiNetTool loginWithPasswdDataWithParams:param.mj_keyValues Success:^{
        DLog(@"静态IP设置成功");
        //跳转
        [weakSelf networkStatusData];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    __block NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        DLog(@"网络状态正常");
        SXDynamicController *dynamicVC = [[SXDynamicController alloc] init];
        [weakSelf.navigationController pushViewController:dynamicVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count++ != 5) {
                [weakSelf networkStatusData];
            }
        });
    }];
}

@end
