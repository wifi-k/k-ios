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
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"找回密码";
    
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
//    param.mobile = self.param.mobile;
//    param.vcode = self.param.vcode;
    param.passwd = self.param.passwd.md5String;
    [SXLoginNetTool resetPasswdDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"发送成功!" toView:SXKeyWindow];
        
        [weakSelf popToLoginVC];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
