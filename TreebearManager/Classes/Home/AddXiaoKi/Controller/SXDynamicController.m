//
//  SXDynamicController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDynamicController.h"
#import "SXDynamicHeaderView.h"
#import "SXAddXiaokiNetTool.h"
#import "NSString+Hash.h"
#import "XKGetWifiNetTool.h"

@interface SXDynamicController ()
///头部视图
@property (nonatomic, weak) SXDynamicHeaderView *headerView;
@end

@implementation SXDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"设置WiFi";
    
    WS(weakSelf);
    SXDynamicHeaderView *headerView = [SXDynamicHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf setNetDynamicData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -网络设置-
- (void)setNetDynamicData{
    WS(weakSelf);
    SXDynamicParam *param = [SXDynamicParam param];
    param.ssid0 = [XKGetWifiNetTool getWifiSSID];
    param.ssid = self.headerView.param.ssid;
    param.passwd = self.headerView.param.passwd.md5String;
    [SXAddXiaokiNetTool ssidSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
