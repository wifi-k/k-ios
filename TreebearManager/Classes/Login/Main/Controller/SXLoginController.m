//
//  SXLoginController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginController.h"
#import "SXRootTool.h"

@interface SXLoginController ()

@end

@implementation SXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorRandom;
}

#pragma mark -跳转Main页面-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [SXRootTool chooseRootWithTabBarVC:SXKeyWindow];
}

@end
