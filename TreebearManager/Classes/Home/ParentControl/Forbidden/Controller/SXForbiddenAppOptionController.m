//
//  SXTimeOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppOptionController.h"

@interface SXForbiddenAppOptionController ()

@end

@implementation SXForbiddenAppOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorBgViewGray;
    
    self.navigationItem.title = @"选择禁用的APP";
    
}

@end
