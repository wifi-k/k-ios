//
//  SXOnlineBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandController.h"
#import "SXOnlineBroadbandHeaderView.h"

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
    
    
//    WS(weakSelf);
    SXOnlineBroadbandHeaderView *headerView = [SXOnlineBroadbandHeaderView headerView];
    headerView.clickDisconnectedBtnBlock = ^{
        [MBProgressHUD showMessage:@"断开连接！" toView:self.view];
    };
    headerView.clickConnectedBtnBlock = ^{
        [MBProgressHUD showMessage:@"重新连接！" toView:self.view];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.headerView.frame = self.view.bounds;
}

@end
