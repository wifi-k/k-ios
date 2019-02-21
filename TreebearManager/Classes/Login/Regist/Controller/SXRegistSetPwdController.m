//
//  SXRegistSetPwdController.m
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistSetPwdController.h"
#import "SXRegistSetPwdHeaderView.h"

@interface SXRegistSetPwdController ()
///头部视图
@property (nonatomic, weak) SXRegistSetPwdHeaderView *headerView;
@end

@implementation SXRegistSetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXRegistSetPwdHeaderView *headerView = [SXRegistSetPwdHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
