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
#import "NSString+Hash.h"

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
    
    self.view.backgroundColor = SXColorRandom;
    
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
//    WS(weakSelf);
    SXRegistParam *param = [SXRegistParam param];
    param.passwd = self.headerView.param.passwd.md5String;
    [SXLoginNetTool setPasswdDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
