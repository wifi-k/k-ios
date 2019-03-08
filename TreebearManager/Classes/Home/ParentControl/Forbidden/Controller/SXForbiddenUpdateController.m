//
//  SXForbiddenAppUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenUpdateController.h"
#import "SXForbiddenDeviceOptionController.h"
#import "SXForbiddenAppOptionController.h"
#import "SXForbiddenUpdateHeaderView.h"
#import "SXWifiSettingAlertView.h"

@interface SXForbiddenUpdateController ()
///头部视图
@property (nonatomic, weak) SXForbiddenUpdateHeaderView *headerView;
@end

@implementation SXForbiddenUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorBgViewGray;
    
    self.navigationItem.title = @"新增|编辑";
    
    WS(weakSelf);
    SXForbiddenUpdateHeaderView *headerView = [SXForbiddenUpdateHeaderView headerView];
    headerView.clickUpdateNameBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickForbiddenAppBlock = ^{
        [weakSelf jumpForbiddenAppOptionVC];
    };
    headerView.clickDeviceControlBlock = ^{
        [weakSelf jumpToDeviceVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpToDeviceVC{
    SXForbiddenDeviceOptionController *fdf = [[SXForbiddenDeviceOptionController alloc] init];
    [self.navigationController pushViewController:fdf animated:YES];
}

- (void)jumpForbiddenAppOptionVC{
    SXForbiddenAppOptionController *fdf = [[SXForbiddenAppOptionController alloc] init];
    [self.navigationController pushViewController:fdf animated:YES];
}

@end