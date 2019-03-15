//
//  SXNetBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetBroadbandController.h"
#import "SXDynamicController.h"
#import "SXNetBroadbandHeaderView.h"
#import "SXNetBroadbandParam.h"
#import "SXAddXiaokiNetTool.h"
#import "NSString+Hash.h"

@interface SXNetBroadbandController ()
///头部视图
@property (nonatomic, weak) SXNetBroadbandHeaderView *headerView;
@end

@implementation SXNetBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"宽带拨号上网";
    
    WS(weakSelf);
    SXNetBroadbandHeaderView *headerView = [SXNetBroadbandHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf jumpToNetDynamicVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -跳转动态设置页面-
- (void)jumpToNetDynamicVC{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = self.headerView.param.name;
    param.passwd = self.headerView.param.passwd.md5String;
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        DLog(@"宽带拨号成功");
        [weakSelf networkStatusData];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    __block NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        DLog(@"网络状态正常");
        SXDynamicController *dynamicVC = [[SXDynamicController alloc] init];
        [weakSelf.navigationController pushViewController:dynamicVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count++ != 5) {
                [weakSelf networkStatusData];
            }
        });
    }];
}

@end
