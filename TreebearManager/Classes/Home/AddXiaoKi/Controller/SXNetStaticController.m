//
//  SXNetStaticController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetStaticController.h"
#import "SXNetStaticHeaderView.h"

@interface SXNetStaticController ()
///头部视图
@property (nonatomic, weak) SXNetStaticHeaderView *headerView;
@end

@implementation SXNetStaticController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"静态IP上网";
    
    WS(weakSelf);
    SXNetStaticHeaderView *headerView = [SXNetStaticHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf setNetStaticData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -网络设置-
- (void)setNetStaticData{
    DLog(@"静态IP - 网络设置");
    [MBProgressHUD showMessage:@"静态IP - 网络设置 - 成功" toView:self.view];
}

@end
