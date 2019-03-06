//
//  SXDynamicController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDynamicController.h"
#import "SXDynamicHeaderView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXDynamicController ()
///头部视图
@property (nonatomic, weak) SXDynamicHeaderView *headerView;
@end

@implementation SXDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"动态IP上网";
    
    WS(weakSelf);
    SXDynamicHeaderView *headerView = [SXDynamicHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf setNetDynamicData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -网络设置-
- (void)setNetDynamicData{
    WS(weakSelf);
    SXDynamicParam *param = [SXDynamicParam param];
    param.ssid = self.headerView.param.ssid;
    param.passwd = self.headerView.param.passwd;
    [SXAddXiaokiNetTool ssidSettingWithDataWithParams:param.mj_keyValues Success:^{
        SXDynamicController *dynamicVC = [[SXDynamicController alloc] init];
        [weakSelf.navigationController pushViewController:dynamicVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
