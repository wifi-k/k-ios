//
//  SXCodeLoginController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXCodeLoginController.h"

@interface SXCodeLoginController ()

@end

@implementation SXCodeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"快捷登录";
    
    self.view.backgroundColor = SXColorRandom;
}

@end
