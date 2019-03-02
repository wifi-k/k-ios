//
//  SXHealtyControlController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlController.h"
#import "SXHealtyTimeController.h"
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
    
    WS(weakSelf);
    SXHealtyControlHeaderView *headerView = [SXHealtyControlHeaderView headerView];
    headerView.clickEditTimeBlock = ^{
        [weakSelf jumpToTimeVC];
    };
    headerView.clickAddTimeBlock = ^{
        [weakSelf jumpToTimeVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -页面跳转-
- (void)jumpToTimeVC{
    SXHealtyTimeController *timeVC = [[SXHealtyTimeController alloc] init];
    [self.navigationController pushViewController:timeVC animated:YES];
}

@end
