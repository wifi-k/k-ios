//
//  SXOnlineBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandController.h"
#import "SXOnlineBroadbandHeaderView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXOnlineBroadbandController ()
///头部视图
@property (nonatomic, weak) SXOnlineBroadbandHeaderView *headerView;
@end

@implementation SXOnlineBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"宽带拨号上网";
    
    
    WS(weakSelf);
    SXOnlineBroadbandHeaderView *headerView = [SXOnlineBroadbandHeaderView headerView];
    headerView.clickDisconnectedBtnBlock = ^{
        [weakSelf broadbandSettingDataError];
    };
    headerView.clickConnectedBtnBlock = ^{
        [weakSelf broadbandSettingData];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.headerView.frame = self.view.bounds;
}

#pragma mark -宽带设置-
- (void)broadbandSettingData{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = self.headerView.param.name;
    param.passwd = self.headerView.param.passwd;
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"固定IP地址设置成功!" toView:weakSelf.view];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)broadbandSettingDataError{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = [NSString stringWithFormat:@"%@123",self.headerView.param.name];
    param.passwd = self.headerView.param.passwd;
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"断开成功!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
