//
//  SXCodeLoginController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXCodeLoginController.h"
#import "SXRegistController.h"
#import "SXCodeLoginHeaderView.h"
#import "SXLoginRegistAlertView.h"

@interface SXCodeLoginController ()
///头部视图
@property (nonatomic, weak) SXCodeLoginHeaderView *headerView;
@end

@implementation SXCodeLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"快捷登录";
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXCodeLoginHeaderView *headerView = [SXCodeLoginHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf alertRegistView];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)alertRegistView{
    WS(weakSelf);
    SXLoginRegistAlertView *registAlertView = [SXLoginRegistAlertView alertWithTitle:@"提示" content:@"该手机号已注册，请立即登录" confirmStr:@"确定" cancelStr:@"取消"];
    registAlertView.confirmButtonBlock = ^{
        [weakSelf jumpToRegistVC];
    };
    [registAlertView alert];
}

- (void)jumpToRegistVC{
    SXRegistController *forgetVC = [[SXRegistController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

@end
