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
    headerView.clickConfirmBtnBlock = ^(NSString *mobile) {
        [weakSelf updateMobileData:mobile];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -Event-
- (void)updateMobileData:(NSString *)mobile{
    //赋值
    SXPersonInfoModel.sharedSXPersonInfoModel.result.user.mobile = mobile;
    
    [SXNotificationCenterTool postNotificationUpdateMobileSuccess];
    
    [MBProgressHUD showSuccessWithMessage:@"更换手机号成功!" toView:SXKeyWindow];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
