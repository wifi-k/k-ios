//
//  SXUpdateVersionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUpdateVersionController.h"
#import "SXUpdateVersionHeaderView.h"
#import "SXMineNetTool.h"

@interface SXUpdateVersionController ()
///头部视图
@property (nonatomic, weak) SXUpdateVersionHeaderView *headerView;
@end

@implementation SXUpdateVersionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"升级版本";
    
    WS(weakSelf);
    SXUpdateVersionHeaderView *headerView = [SXUpdateVersionHeaderView headerView];
    headerView.model = self.model;
    headerView.clickUpdateBtnBlock = ^{
        if ([NSString isEmpty:weakSelf.model.firmwareUpgrade]) {
            [MBProgressHUD showWarningWithMessage:@"您的固件版本已经是最新!" toView:SXKeyWindow];
            return;
        }
        
        [weakSelf userNodeFirmwareUpgrade];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -升级固件-
- (void)userNodeFirmwareUpgrade{
    //更新wan信息
    if ([NSString isEmpty:self.model.nodeId]) {
        [MBProgressHUD showWarningWithMessage:@"没有获取到节点，请检查系统网络设置!" toView:SXKeyWindow];
        return;
    }
    
    [MBProgressHUD showWhiteLoadingWithMessage:@"升级中..." toView:SXKeyWindow];
    [SXMineNetTool userNodeFirmwareUpgradeParams:self.model.nodeId Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccessWithMessage:@"升级成功!" toView:SXKeyWindow];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

@end
