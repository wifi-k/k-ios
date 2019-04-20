//
//  SXMobileUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileUpdateController.h"
#import "SXMobileUpdateHeaderView.h"
#import "SXNotificationCenterTool.h"
#import "SXMineNetTool.h"

@interface SXMobileUpdateController ()
@property (nonatomic, weak) SXMobileUpdateHeaderView *headerView;//头部视图
@end

@implementation SXMobileUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"更换手机号";
    
    //2.头部视图
    WS(weakSelf);
    SXMobileUpdateHeaderView *headerView = [SXMobileUpdateHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^(SXLoginParam *param) {
        [weakSelf updateMobileData:param];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -Event-
#pragma mark -修改手机号-
- (void)updateMobileData:(SXLoginParam *)param{
    WS(weakSelf);
    [SXMineNetTool userMobileVerifyParams:param.mj_keyValues Success:^{
        //赋值
        SXPersonInfoModel.sharedSXPersonInfoModel.result.user.mobile = param.mobile;
        
        [SXNotificationCenterTool postNotificationUpdateMobileSuccess];
        
        [MBProgressHUD showSuccessWithMessage:@"更换手机号成功!" toView:SXKeyWindow];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

@end
