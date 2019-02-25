//
//  SXHealtyControlController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlController.h"
#import "SXHealtyControlHeaderView.h"

@interface SXHealtyControlController ()
///头部视图
@property (nonatomic, weak) SXHealtyControlHeaderView *headerView;
@end

@implementation SXHealtyControlController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"健康模式";
    
    SXHealtyControlHeaderView *headerView = [SXHealtyControlHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
