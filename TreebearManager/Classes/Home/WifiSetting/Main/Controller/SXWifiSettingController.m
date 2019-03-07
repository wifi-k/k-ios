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
#import "SXRestartController.h"
#import "SXDHCPServerController.h"
#import "SXRestoreController.h"
#import "SXWifiSettingHeaderView.h"
#import "SXWifiSettingAlertView.h"

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
    switch (tag) {
        case 0:{
            SXPreventController *preventVC = [[SXPreventController alloc] init];
            [self.navigationController pushViewController:preventVC animated:YES];
        }
            break;
        case 1:{
            SXAdvancedController *advancedVC = [[SXAdvancedController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 2:{
            SXOnlineController *advancedVC = [[SXOnlineController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 3:{
            SXLANPortController *advancedVC = [[SXLANPortController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 4:{
            SXRestartController *advancedVC = [[SXRestartController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 5:{
            SXDHCPServerController *advancedVC = [[SXDHCPServerController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 6:{
            SXRestoreController *advancedVC = [[SXRestoreController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 7:
            DLog(@"tag:%ld",tag);
            break;
        default:
            break;
    }
}

@end
