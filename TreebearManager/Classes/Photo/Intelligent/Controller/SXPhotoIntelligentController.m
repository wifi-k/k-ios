//
//  SXPhotoIntelligentController.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoIntelligentController.h"

@interface SXPhotoIntelligentController ()

@end

@implementation SXPhotoIntelligentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"智能相册";    
}

@end
