//
//  SXMobileInfoController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileInfoController.h"
#import "SXMobileInfoHeaderView.h"

@interface SXMobileInfoController ()
@property (nonatomic, weak) SXMobileInfoHeaderView *headerView;//头部视图
@end

@implementation SXMobileInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"设备信息";
    
    //1.头部视图
    SXMobileInfoHeaderView *headerView = [SXMobileInfoHeaderView headerView];
    headerView.model = self.model;
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
