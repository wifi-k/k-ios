//
//  SXAdvancedOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAdvancedOptionController.h"

@interface SXAdvancedOptionController ()

@end

@implementation SXAdvancedOptionController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

- (void)setUpUI{

    self.view.backgroundColor = SXColorWhite;
        
    self.navigationItem.title = @"高级选项";
}

@end
