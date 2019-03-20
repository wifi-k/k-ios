//
//  SXDynamicController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDynamicController.h"
#import "SXDynamicHeaderView.h"
#import "SXTitleAlertView.h"
#import "SXAddXiaokiNetTool.h"
#import "NSString+Hash.h"
#import "XKGetWifiNetTool.h"
#import "SXRootTool.h"
@class SXAddXiaoKiController;

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
        //1.指示器
        [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:weakSelf.view];
        //2.WiFi名称已经更改，前往系统设置重新连接
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf alertOnNetAlertView];
        });
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -视图弹窗-
- (void)alertOnNetAlertView{
    SXTitleAlertView *netAlertView = [SXTitleAlertView alertWithTitle:@"连网提示" content:@"请前往手机系统设置,重新连接WiFi" confirmStr:@"确定" cancelStr:@"取消"];
    netAlertView.confirmButtonBlock = ^{
        [SXRootTool jumpToSystemWIFI];
        //同时跳转
        [SXRootTool popToVC:@"SXAddXiaoKiController"];
    };
    netAlertView.cancelButtonBlock = ^{
        [SXRootTool popToVC:@"SXAddXiaoKiController"];
    };
    [netAlertView alert];
}

@end
