//
//  SXShareMemberManageController.m
//  TreebearManager
//
//  Created by bear on 2019/4/23.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXShareMemberManageController.h"

@interface SXShareMemberManageController ()

@end

@implementation SXShareMemberManageController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"添加家庭成员";
}

@end
