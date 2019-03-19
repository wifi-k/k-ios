//
//  SXOnlineFixedIPController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineFixedIPController.h"
#import "SXOnlineFixedIPHeaderView.h"

@interface SXOnlineFixedIPController ()
///头部视图
@property (nonatomic, weak) SXOnlineFixedIPHeaderView *headerView;
@end

@implementation SXOnlineFixedIPController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorRandom;
    
//    self.navigationItem.title = @"固定IP地址";
    
    WS(weakSelf);
    SXOnlineFixedIPHeaderView *headerView = [SXOnlineFixedIPHeaderView headerView];
    headerView.clickSaveBtnBlock = ^{
        [weakSelf fdfdfdfd];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -Event-
- (void)fdfdfdfd{
    DLog(@"fdfdfdfd");
}

@end
