//
//  SXMineSettingController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineSettingController.h"
#import "SXMineAboutUsController.h"
#import "SXMineVersionUpdateController.h"
#import "SXMineSettingHeaderView.h"
#import "SXRootTool.h"
#import "SXMineNetTool.h"

@interface SXMineSettingController ()
@property (nonatomic, weak) SXMineSettingHeaderView *headerView;//头部视图
@end

@implementation SXMineSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"设置";
    
    self.view.backgroundColor = SXColorWhite;
    
    //2.头部视图
    WS(weakSelf);
    SXMineSettingHeaderView *headerView = [SXMineSettingHeaderView headerView];
    headerView.clickAboutUsBlock = ^{
        SXMineAboutUsController *aboutVC = [[SXMineAboutUsController alloc] init];
        [weakSelf.navigationController pushViewController:aboutVC animated:YES];
    };
    headerView.clickUpdateVersionBlock = ^{
        SXMineVersionUpdateController *updateVC = [[SXMineVersionUpdateController alloc] init];
        [weakSelf.navigationController pushViewController:updateVC animated:YES];
    };
    headerView.clickLogoutBtnBlock = ^{
        [weakSelf logoutData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -退出登录-
- (void)logoutData{
    [MBProgressHUD showWhiteLoadingWithMessage:@"正在退出..." toView:SXKeyWindow];
    [SXMineNetTool userQuitSuccess:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showMessage:@"已退出登录!" toView:SXKeyWindow];
        //切换根控
        [SXRootTool chooseRootWithLoginVC:SXDelegateWindow];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
