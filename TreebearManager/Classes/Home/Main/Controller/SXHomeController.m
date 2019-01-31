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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"首页";
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [SXRootTool change];
}

@end
