//
//  SXWifiSettingController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingController.h"
#import "SXNetWallController.h"
#import "SXWifiSettingHeaderView.h"
#import "SXWifiSettingCell.h"
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
    
    self.navigationItem.title = @"Wifi设置";
    
    //2.头部视图
    WS(weakSelf);
    SXWifiSettingHeaderView *headerView = [SXWifiSettingHeaderView headerView];
    headerView.clickWifiNameBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickWifiPasswordBlock = ^{
        [weakSelf alertUpdatePwdView];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 318);
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
- (void)jumpToNetVC{
    SXNetWallController *netVC = [[SXNetWallController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXWifiSettingCell *cell = [SXWifiSettingCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self jumpToNetVC];
}

@end
