//
//  SXMineChildController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineChildController.h"

@interface SXMineChildController ()

@end

@implementation SXMineChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"我的孩子";
    
    self.view.backgroundColor = SXColorWhite;
}

@end
