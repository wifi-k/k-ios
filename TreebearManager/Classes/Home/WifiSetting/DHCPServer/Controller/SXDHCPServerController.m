//
//  SXDHCPServerController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDHCPServerController.h"
#import "SXDHCPServerHeaderView.h"

@interface SXDHCPServerController ()
///头部视图
@property (nonatomic, weak) SXDHCPServerHeaderView *headerView;
@end

@implementation SXDHCPServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"DHCP服务器";

    WS(weakSelf);
    SXDHCPServerHeaderView *headerView = [SXDHCPServerHeaderView headerView];
    headerView.clickSaveBtnBlock = ^{
        [weakSelf jumpToVC];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.tableView.frame = self.view.bounds;
//    
//    self.headerView.frame = self.view.bounds;
}

- (void)jumpToVC{
    [MBProgressHUD showMessage:@"保存成功" toView:self.view];
}

@end
