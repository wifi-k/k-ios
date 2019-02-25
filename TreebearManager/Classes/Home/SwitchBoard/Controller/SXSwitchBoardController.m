//
//  SXSwitchBoardController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXSwitchBoardController.h"
#import "SXSwitchBoardHeaderView.h"

@interface SXSwitchBoardController ()
///头部视图
@property (nonatomic, weak) SXSwitchBoardHeaderView *headerView;
@end

@implementation SXSwitchBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"开关面板灯";
    
    SXSwitchBoardHeaderView *headerView = [SXSwitchBoardHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}


@end
