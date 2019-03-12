//
//  SXLANPortController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLANPortController.h"
#import "SXLANPortHeaderView.h"

@interface SXLANPortController ()
///头部视图
@property (nonatomic, weak) SXLANPortHeaderView *headerView;
@end

@implementation SXLANPortController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"LAN口设置";
    
    WS(weakSelf);
    SXLANPortHeaderView *headerView = [SXLANPortHeaderView headerView];
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
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
}

@end
