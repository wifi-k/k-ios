//
//  SXHomeController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeController.h"
#import "SXRootTool.h"
#import "SXTabBarController.h"
#import "SXNavigationController.h"
#import "SXMineController.h"
#import "SXHomeHeaderView.h"

@interface SXHomeController ()
///头部视图
@property (nonatomic, weak) SXHomeHeaderView *headerView;
    
@end

@implementation SXHomeController

#pragma mark -控制器生命周期方法-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = [UIColor hex:@"444652"];
    //self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
    
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = UIColor.blueColor;
    //self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"首页";
    
    SXHomeHeaderView *headerView = [SXHomeHeaderView headerView];
    headerView.clickBindingBtnBlock = ^{
        [SXRootTool changeToMainHomeVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
 
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
