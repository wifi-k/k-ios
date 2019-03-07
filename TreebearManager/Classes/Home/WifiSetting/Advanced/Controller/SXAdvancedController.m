//
//  SXAdvancedController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAdvancedController.h"
#import "SXAdvancedHeaderView.h"

@interface SXAdvancedController ()
///头部视图
@property (nonatomic, weak) SXAdvancedHeaderView *headerView;
@end

@implementation SXAdvancedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"无线高级设置";
    
    WS(weakSelf);
    SXAdvancedHeaderView *headerView = [SXAdvancedHeaderView headerView];
    headerView.clickSaveBtnBlock = ^{
        [weakSelf jumpToVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)jumpToVC{
    DLog(@"保存...");
}

@end
