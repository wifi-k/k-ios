//
//  SXMobileDetailController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileDetailController.h"
#import "SXMobileInfoController.h"
#import "SXMobileDetailHeaderView.h"

@interface SXMobileDetailController ()
@property (nonatomic, weak) SXMobileDetailHeaderView *headerView;//头部视图
@end

@implementation SXMobileDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"设备详情";
    
    WS(weakSelf);
    SXMobileDetailHeaderView *headerView = [SXMobileDetailHeaderView headerView];
    headerView.clickCenterFirstBgViewBlock = ^{
        [weakSelf jumpToMobileInfoVC];
    };
    headerView.clickEditBtnBlock = ^{
        [MBProgressHUD showMessage:@"编辑中" toView:weakSelf.view];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 750);
}

#pragma mark -点击事件-
- (void)jumpToMobileInfoVC{
    SXMobileInfoController *infoVC = [[SXMobileInfoController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
