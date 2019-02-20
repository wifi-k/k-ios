//
//  SXForgetController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetController.h"
#import "SXForgetConfirmController.h"
#import "SXForgetHeaderView.h"

@interface SXForgetController ()
///头部视图
@property (nonatomic, weak) SXForgetHeaderView *headerView;
@end

@implementation SXForgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}
    
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"找回密码";
    
    WS(weakSelf);
    SXForgetHeaderView *headerView = [SXForgetHeaderView headerView];
    headerView.clickNextBtnBlock = ^{
        [weakSelf jumpToConfirmVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}
    
- (void)jumpToConfirmVC{
    SXForgetConfirmController *confirmVC = [[SXForgetConfirmController alloc] init];
    confirmVC.param = self.headerView.param;
    [self.navigationController pushViewController:confirmVC animated:YES];
}
    
@end
