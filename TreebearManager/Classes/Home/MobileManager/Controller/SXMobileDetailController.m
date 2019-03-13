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
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -点击事件-
- (void)jumpToMobileInfoVC{
    SXMobileInfoController *infoVC = [[SXMobileInfoController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
