//
//  SXOnlineBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandController.h"
#import "SXOnlineBroadbandHeaderView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXOnlineBroadbandController ()
///头部视图
@property (nonatomic, weak) SXOnlineBroadbandHeaderView *headerView;
@end

@implementation SXOnlineBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"宽带拨号上网";
    
    
    WS(weakSelf);
    SXOnlineBroadbandHeaderView *headerView = [SXOnlineBroadbandHeaderView headerView];
    headerView.clickDisconnectedBtnBlock = ^{
        [weakSelf broadbandSettingDataError];
    };
    headerView.clickConnectedBtnBlock = ^{
        [weakSelf broadbandSettingData];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.headerView.frame = self.view.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    self.headerView.frame = self.view.bounds;
}

#pragma mark -宽带设置-
- (void)broadbandSettingData{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = self.headerView.param.name;
    param.passwd = self.headerView.param.passwd;
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"固定IP地址设置成功!" toView:weakSelf.view];
        //网络状态->获取节点
        [weakSelf networkStatusData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

- (void)broadbandSettingDataError{
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = [NSString stringWithFormat:@"%@123",self.headerView.param.name];
    param.passwd = self.headerView.param.passwd;
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool broadbandSettingWithDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"断开成功!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    static NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        DLog(@"网络状态正常");
        //获取节点信息
        [weakSelf getNodeData];
    } failure:^(NSError * _Nonnull error) {
        ++count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count%5 != 0) {
                [weakSelf networkStatusData];
            } else{
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"请检查配置参数，然后重试!" toView:weakSelf.view];
                });
            }
        });
    }];
}

#pragma mark -获取节点数据-
- (void)getNodeData{
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"获取节点");
        //更新wan信息
        SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
        [shareInfo setDataWithResult:result];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
    }];
}

@end
