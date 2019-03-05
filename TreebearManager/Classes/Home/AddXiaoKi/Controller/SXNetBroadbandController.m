//
//  SXNetBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetBroadbandController.h"
#import "SXDynamicController.h"
#import "SXNetBroadbandHeaderView.h"

@interface SXNetBroadbandController ()
///头部视图
@property (nonatomic, weak) SXNetBroadbandHeaderView *headerView;
@end

@implementation SXNetBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"宽带拨号上网";
    
    WS(weakSelf);
    SXNetBroadbandHeaderView *headerView = [SXNetBroadbandHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf jumpToNetDynamicVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -跳转动态设置页面-
- (void)jumpToNetDynamicVC{
    SXDynamicController *dynamicVC = [[SXDynamicController alloc] init];
    [self.navigationController pushViewController:dynamicVC animated:YES];
}

@end
