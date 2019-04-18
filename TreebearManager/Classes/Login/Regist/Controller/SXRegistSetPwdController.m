//
//  SXRegistSetPwdController.m
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistSetPwdController.h"
#import "SXRegistSetPwdHeaderView.h"
#import "SXLoginNetTool.h"
#import "SXRootTool.h"
#import "NSString+Hash.h"
#import "SXUserDefaultsTool.h"

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
    
    self.view.backgroundColor = SXColorWhite;
    
    WS(weakSelf);
    SXRegistSetPwdHeaderView *headerView = [SXRegistSetPwdHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf resetPasswordData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)resetPasswordData{
    WS(weakSelf);
    SXRegistParam *param = [SXRegistParam param];
    param.passwd = self.headerView.param.passwd.md5String;
    [SXLoginNetTool setPasswdDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf changeRootVC];
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
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
            [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
        }
    });
}

@end
