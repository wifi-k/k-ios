//
//  SXOnlineFixedIPController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineFixedIPController.h"
#import "SXOnlineFixedIPHeaderView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXOnlineFixedIPController ()
///头部视图
@property (nonatomic, weak) SXOnlineFixedIPHeaderView *headerView;
@end

@implementation SXOnlineFixedIPController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"固定IP地址";
    
    WS(weakSelf);
    SXOnlineFixedIPHeaderView *headerView = [SXOnlineFixedIPHeaderView headerView];
    headerView.clickSaveBtnBlock = ^{
        [weakSelf staticSettingWithData];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.headerView.frame = self.view.bounds;
}

#pragma mark -Event-
- (void)staticSettingWithData{
    SXNetStaticParam *param = [SXNetStaticParam param];
    param.ip = self.headerView.param.ip;
    param.netmask = self.headerView.param.netmask;
    param.gateway = self.headerView.param.gateway;
    param.dns1 = self.headerView.param.dns1;
    param.dns2 = self.headerView.param.dns2;
    [MBProgressHUD showWhiteLoadingWithMessage:nil toView:SXKeyWindow];
    [SXAddXiaokiNetTool staticSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showFailWithMessage:@"固定IP地址设置成功" toView:SXKeyWindow];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
