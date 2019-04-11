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
#import "SXUserGuideController.h"
#import "SXLoginHeaderView.h"
#import "SXRootTool.h"
#import "SXLoginNetTool.h"
#import "NSString+Hash.h"
#import "SXUserDefaultsTool.h"
#import "SXMineNetTool.h"

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
//    self.navigationItem.title = @"登录小K云管家";
    
    self.view.backgroundColor = SXColorWhite;
    
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
    param.devType = @1;
    param.devToken = SXUserDefaultsTool.deviceToken;
    param.devOs = DEVICE_MODEL;
    [SXLoginNetTool loginWithPasswordDataWithParams:param.mj_keyValues Success:^{
        [weakSelf changeRootVC];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

//切换根控制器
- (void)changeRootVC{
    [MBProgressHUD showWhiteLoadingWithMessage:@"即将登录..." toView:SXKeyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        if (![SXUserDefaultsTool isShowGuide]) {
            [SXRootTool chooseRootWithGuideVC:SXDelegateWindow];
        } else {
            [self userInfoGetextData];
        }
    });
}

#pragma mark -获取用户信息数据接口-
- (void)userInfoGetextData{
    [SXMineNetTool userInfoGetextDataWithFilter:@1 Success:^(SXMineUserInfoResult *result) {
        //1.单利赋值
        SXPersonInfoModel.sharedSXPersonInfoModel.result = result;
        //2.头部赋值
        if (result.nodeSize.integerValue > 0) {//列表有数据
            [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
            [SXRootTool changeToMainHomeVC];
        } else {
            [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
        }
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
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
