//
//  SXWifiSettingController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingController.h"
#import "SXPreventController.h"
#import "SXAdvancedController.h"
#import "SXOnlineController.h"
#import "SXLANPortController.h"
#import "SXDHCPServerController.h"
#import "SXWifiSettingHeaderView.h"
#import "SXWifiSettingAlertView.h"
#import "SXTitleAlertView.h"
#import "SXWarningAlertView.h"
#import "SXWifiSettingNetTool.h"

@interface SXWifiSettingController ()
@property (nonatomic, weak) SXWifiSettingHeaderView *headerView;//头部视图
@end

@implementation SXWifiSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"WiFi工具箱";
    
    //2.头部视图
    WS(weakSelf);
    SXWifiSettingHeaderView *headerView = [SXWifiSettingHeaderView headerView];
    headerView.clickWifiNameBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickWifiPasswordBlock = ^{
        [weakSelf alertUpdatePwdView];
    };
    headerView.clickAdvancedBtnBlock = ^(NSInteger tag) {
        [weakSelf jumpToSettingVC:tag];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

- (void)alertUpdatePwdView{
    SXWifiSettingAlertView *pwdAlertV = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的密码" confirmStr:@"确定" cancelStr:@"取消"];
    pwdAlertV.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [pwdAlertV alert];
}

#pragma mark -页面跳转-
- (void)jumpToSettingVC:(NSInteger)tag{
    WS(weakSelf);
    switch (tag) {
        case 0:{
            SXPreventController *preventVC = [[SXPreventController alloc] init];
            [self.navigationController pushViewController:preventVC animated:YES];
        }
            break;
        case 1:{
            SXOnlineController *advancedVC = [[SXOnlineController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
//            SXAdvancedController *advancedVC = [[SXAdvancedController alloc] init];
//            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 2:{
            
            SXWarningAlertView *netAlertView = [SXWarningAlertView alertWithTitle:@"请确认是否重启" content:@"路由器重启预计需要几分钟时间，重启过程中，所有已连设备会断开连接" confirmStr:@"确定" cancelStr:@"取消"];
            netAlertView.confirmButtonBlock = ^{
                [weakSelf nodeRestartWithData];
            };
            netAlertView.cancelButtonBlock = ^{
                
            };
            [netAlertView alert];
        }
            break;
        case 3:{
            SXWarningAlertView *netAlertView = [SXWarningAlertView alertWithTitle:@"请确认是否恢复出厂设置" content:@"路由器的所有配置将恢复至出厂时的默认状态" confirmStr:@"确定" cancelStr:@"取消"];
            netAlertView.confirmButtonBlock = ^{
                [weakSelf nodeResetWithData];
            };
            netAlertView.cancelButtonBlock = ^{
                
            };
            [netAlertView alert];

        }
            break;
        case 4:{
            
//            SXLANPortController *advancedVC = [[SXLANPortController alloc] init];
//            [self.navigationController pushViewController:advancedVC animated:YES];
            //SXRestartController *advancedVC = [[SXRestartController alloc] init];
            //[self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 5:{
//            SXDHCPServerController *advancedVC = [[SXDHCPServerController alloc] init];
//            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 6:{
            DLog(@"tag:%ld",tag);
        }
            break;
        case 7:
            DLog(@"tag:%ld",tag);
            break;
        default:
            break;
    }
}

#pragma mark -网络请求-
- (void)nodeRestartWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"重启中..." toView:self.view];
    [SXWifiSettingNetTool nodeRestartWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"重启节点OK!");
        [MBProgressHUD showMessage:@"重启节点OK!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)nodeResetWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"恢复中..." toView:self.view];
    [SXWifiSettingNetTool nodeResetWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"恢复出厂设置OK!");
        [MBProgressHUD showMessage:@"恢复出厂设置OK!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
