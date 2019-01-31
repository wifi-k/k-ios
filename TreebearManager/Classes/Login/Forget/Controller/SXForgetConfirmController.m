//
//  SXForgetConfirmController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetConfirmController.h"
#import "SXForgetConfirmHeaderView.h"

@interface SXForgetConfirmController ()
///头部视图
@property (nonatomic, weak) SXForgetConfirmHeaderView *headerView;
@end

@implementation SXForgetConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"找回密码";
    
    SXForgetConfirmHeaderView *headerView = [SXForgetConfirmHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}
    
@end
