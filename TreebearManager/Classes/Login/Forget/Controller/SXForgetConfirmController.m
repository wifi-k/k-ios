//
//  SXForgetConfirmController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetConfirmController.h"
#import "SXForgetConfirmHeaderView.h"
#import "SXLoginNetTool.h"
#import "NSString+Hash.h"

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
    
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"找回密码";
    
    WS(weakSelf);
    SXForgetConfirmHeaderView *headerView = [SXForgetConfirmHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf resetPasswordData];
    };
    headerView.param = self.param;
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)resetPasswordData{
    WS(weakSelf);
    SXRegistParam *param = [SXRegistParam param];
    param.mobile = self.param.mobile;
    param.vcode = self.param.vcode;
    param.passwd = self.param.passwd.md5String;
    [SXLoginNetTool resetPasswdDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"密码重置成功!" toView:SXKeyWindow];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf popToLoginVC];
        });
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

//跳转回登录页面
- (void)popToLoginVC{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"SXLoginController")]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}
    
@end
