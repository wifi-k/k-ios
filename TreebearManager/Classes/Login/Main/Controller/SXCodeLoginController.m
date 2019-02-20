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
#import "SXLoginNetTool.h"
#import "SXRootTool.h"

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
    
    self.view.backgroundColor = SXColorWhite;
    
    WS(weakSelf);
    SXCodeLoginHeaderView *headerView = [SXCodeLoginHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf loginWithVCode];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

//提示跳转注册弹窗
- (void)alertRegistView{
    WS(weakSelf);
    SXLoginRegistAlertView *registAlertView = [SXLoginRegistAlertView alertWithTitle:@"提示" content:@"该手机号已注册，请立即登录" confirmStr:@"确定" cancelStr:@"取消"];
    registAlertView.confirmButtonBlock = ^{
        [weakSelf jumpToRegistVC];
    };
    [registAlertView alert];
}

#pragma mark -快捷登录-
- (void)loginWithVCode{
    WS(weakSelf);
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = self.headerView.param.mobile;
    param.vcode = self.headerView.param.vcode;
    [SXLoginNetTool loginWithVCodeDataWithParams:param.mj_keyValues Success:^{
        [weakSelf changeRootVC];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

//跳转注册页面
- (void)jumpToRegistVC{
    SXRegistController *forgetVC = [[SXRegistController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

//切换根控制器
- (void)changeRootVC{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"即将登录..." toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf.view];
        
        [SXRootTool chooseRootWithTabBarVC:SXKeyWindow];
    });
}

@end
