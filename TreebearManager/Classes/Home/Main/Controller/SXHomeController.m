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

@interface SXHomeController ()

@end

@implementation SXHomeController

#pragma mark -控制器生命周期方法-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = [UIColor hex:@"444652"];
    self.navigationController.navigationBar.hidden = YES;
}
    
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = UIColor.blueColor;
    self.navigationController.navigationBar.hidden = NO;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"首页";
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SXRootTool changeToMainHomeVC];
}

@end
