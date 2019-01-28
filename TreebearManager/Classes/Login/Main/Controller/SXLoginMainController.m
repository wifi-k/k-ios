//
//  SXLoginMainController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginMainController.h"
#import "SXLoginMainHeaderView.h"
#import "SXLoginController.h"
#import "SXRegistController.h"

@interface SXLoginMainController ()

///头部视图
@property (nonatomic, weak) SXLoginMainHeaderView *headerView;
@end

@implementation SXLoginMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"登录";
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXLoginMainHeaderView *headerView = [SXLoginMainHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf jumpToLoginVC];
    };
    headerView.clickRegistBtnBlock = ^{
        [weakSelf jumpToRegistVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}


#pragma mark -跳转登录页面-
- (void)jumpToLoginVC{
    SXLoginController *forgetVC = [[SXLoginController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)jumpToRegistVC{
    SXRegistController *forgetVC = [[SXRegistController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

@end
