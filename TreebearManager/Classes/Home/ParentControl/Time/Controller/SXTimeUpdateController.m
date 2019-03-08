//
//  SXTimeUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeUpdateController.h"
#import "SXTimeUpdateHeaderView.h"
#import "SXWifiSettingAlertView.h"

@interface SXTimeUpdateController ()
///头部视图
@property (nonatomic, weak) SXTimeUpdateHeaderView *headerView;
@end

@implementation SXTimeUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"编辑|新增";
    
//    WS(weakSelf);
    SXTimeUpdateHeaderView *headerView = [SXTimeUpdateHeaderView headerView];
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

@end
