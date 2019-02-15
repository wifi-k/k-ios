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
#import "SXTitleAlertView.h"
#import "SXCodeInputAlertView.h"
#import "SXLoginRegistAlertView.h"
#import "SXFamilyCodeSuccessAlertView.h"
#import "SXFamilyCodeFailureAlertView.h"

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
        [weakSelf jumpToMainVC];
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

- (void)jumpToMainVC{
    //[SXRootTool chooseRootWithTabBarVC:SXKeyWindow];
    
//    SXTitleAlertView *fdfdf = [SXTitleAlertView alertWithTitle:@"标题" confirmStr:@"确定" cancelStr:@"取消"];
//    [fdfdf alert];
    
//    SXCodeInputAlertView *input = [SXCodeInputAlertView alertWithTitle:@"输入家庭码加入家庭" confirmStr:@"确定" cancelStr:@"取消"];
//    [input alert];
    
//    SXLoginRegistAlertView *alert = [SXLoginRegistAlertView alertWithTitle:@"提示" content:@"该手机号已注册，请立即登录" confirmStr:@"确定" cancelStr:@"取消"];
//    [alert alert];
    
    SXFamilyCodeSuccessAlertView *alert = [SXFamilyCodeSuccessAlertView alertWithTopImageName:@"home_familycode_success" title:@"家庭码正确" content:nil confirmStr:@"确定"];
    [alert alert];
    
//    SXFamilyCodeFailureAlertView *alert = [SXFamilyCodeFailureAlertView alertWithTopImageName:@"home_familycode_failure" title:@"家庭码错误" content:@"请输入正确的家庭码" confirmStr:@"再次输入"];
//    [alert alert];
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
