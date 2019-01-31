//
//  SXLoginController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginController.h"
#import "SXLoginHeaderView.h"
#import "SXRootTool.h"

@interface SXLoginController ()
///头部视图
@property (nonatomic, weak) SXLoginHeaderView *headerView;
@end

@implementation SXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}
    
- (void)setUpUI{
    self.navigationItem.title = @"登录小K管家";
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXLoginHeaderView *headerView = [SXLoginHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf jumpToMainVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;   
}
    
- (void)jumpToMainVC{
    [SXRootTool chooseRootWithTabBarVC:SXKeyWindow];
}

@end
