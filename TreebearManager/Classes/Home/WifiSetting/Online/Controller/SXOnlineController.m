//
//  SXOnlineController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineController.h"
#import "SXOnlineOptionHeaderView.h"

@interface SXOnlineController ()
///头部视图
@property (nonatomic, weak) SXOnlineOptionHeaderView *headerView;
@end

@implementation SXOnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"上网设置";
    
    SXOnlineOptionHeaderView *headerView = [SXOnlineOptionHeaderView headerView];
    headerView.backgroundColor = SXColorRandom;
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
}

@end
