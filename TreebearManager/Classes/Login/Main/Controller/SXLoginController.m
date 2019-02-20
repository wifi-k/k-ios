//
//  SXLoginController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginController.h"
#import "SXForgetController.h"
#import "SXCodeLoginController.h"
#import "SXLoginHeaderView.h"
#import "SXRootTool.h"
#import "SXLoginNetTool.h"
#import "NSString+Hash.h"

@interface SXLoginController ()
///头部视图
@property (nonatomic, weak) SXLoginHeaderView *headerView;
@end

@implementation SXLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}
    
- (void)setUpUI{
    self.navigationItem.title = @"登录小K管家";
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXLoginHeaderView *headerView = [SXLoginHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf loginWithPasswordData];
    };
    headerView.clickCodeLoginBtnBlock = ^{
        [weakSelf jumpToCodeLoginVC];
    };
    headerView.clickForgetBtnBlock = ^{
        [weakSelf jumpToForgetVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)loginWithPasswordData{
    WS(weakSelf);
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = self.headerView.param.mobile;
    param.passwd = self.headerView.param.passwd.md5String;
    [SXLoginNetTool loginWithPasswordDataWithParams:param.mj_keyValues Success:^(NSString * _Nonnull code) {
        [weakSelf changeRootVC];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

//切换根控制器
- (void)changeRootVC{
    [MBProgressHUD showWhiteLoadingWithMessage:@"即将登录..." toView:SXKeyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        
        [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
    });
}
    
- (void)jumpToForgetVC{
    SXForgetController *forgetVC = [[SXForgetController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}
    
- (void)jumpToCodeLoginVC{
    SXCodeLoginController *codeLoginVC = [[SXCodeLoginController alloc] init];
    [self.navigationController pushViewController:codeLoginVC animated:YES];
}

@end
