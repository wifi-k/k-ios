//
//  SXRegistController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistController.h"
#import "SXLoginController.h"
#import "SXRegistSetPwdController.h"
#import "SXRegistHeaderView.h"
#import "SXLoginRegistAlertView.h"

@interface SXRegistController ()
///头部视图
@property (nonatomic, weak) SXRegistHeaderView *headerView;
@end

@implementation SXRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpUI];
}
    
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    WS(weakSelf);
    SXRegistHeaderView *headerView = [SXRegistHeaderView headerView];
    headerView.registSuccessBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf jumpToSetPwdVC];
        });
    };
    headerView.alertLoginTipsBlock = ^{
        [weakSelf alertLoginTips];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

//提示跳转登录弹窗
- (void)alertLoginTips{
    WS(weakSelf);
    SXLoginRegistAlertView *loginTipsAlert = [SXLoginRegistAlertView alertWithTitle:@"提示" content:@"该手机号已注册，请立即登录" confirmStr:@"立即登录" cancelStr:@"取消"];
    loginTipsAlert.confirmButtonBlock = ^{
        [weakSelf jumpToLoginVC];
    };
    [loginTipsAlert alert];
}

#pragma mark -跳转登录页面-
- (void)jumpToLoginVC{
    SXLoginController *forgetVC = [[SXLoginController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)jumpToSetPwdVC{
    SXRegistSetPwdController *forgetVC = [[SXRegistSetPwdController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

@end
