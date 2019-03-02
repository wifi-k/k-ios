//
//  SXTimeOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeOptionController.h"

@interface SXTimeOptionController ()

@end

@implementation SXTimeOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorBgViewGray;
    
    self.navigationItem.title = @"允许上网时间段";
    
}

@end
