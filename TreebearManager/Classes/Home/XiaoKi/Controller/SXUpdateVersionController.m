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
    headerView.clickUpdateBtnBlock = ^{
        [weakSelf updateVersion];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -升级中-
- (void)updateVersion{
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeFirmwareUpgradeParams:nil Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"OK！" toView:SXKeyWindow];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
