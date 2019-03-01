//
//  SXForbiddenAppUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppUpdateController.h"

@interface SXForbiddenAppUpdateController ()

@end

@implementation SXForbiddenAppUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"新增";
}

@end
