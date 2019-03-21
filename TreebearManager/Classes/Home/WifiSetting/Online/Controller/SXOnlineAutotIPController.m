//
//  SXOnlineAutotIPController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineAutotIPController.h"
#import "SXOnlineAutotIPHeaderView.h"
#import "SXAddXiaokiNetTool.h"
#import "SXXiaoKInfoModel.h"

@interface SXOnlineAutotIPController ()
///头部视图
@property (nonatomic, weak) SXOnlineAutotIPHeaderView *headerView;
@end

@implementation SXOnlineAutotIPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
//    [self getNodeData];
    
    [self dynamicSettingData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    //self.navigationItem.title = @"自动获取IP地址";
    WS(weakSelf);
    SXOnlineAutotIPHeaderView *headerView = [SXOnlineAutotIPHeaderView headerView];
    headerView.clickUpdateIPBtnBlock = ^{
        [weakSelf getNodeData];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -获取节点数据-
- (void)getNodeData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"获取节点");
        //更新wan信息
        SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
        shareInfo.modelId = result.modelId;
        shareInfo.ip = result.wan.ip;
        shareInfo.netmask = result.wan.netmask;
        shareInfo.gateway = result.wan.gateway;
        shareInfo.dns1 = result.wan.dns1;
        shareInfo.dns2 = result.wan.dns2;
        shareInfo.type = result.wan.type;
        shareInfo.name = result.wan.name;
        shareInfo.passwd = result.wan.passwd;
        //更新UI
        weakSelf.headerView.result = result;
        
        //调用接口
        [weakSelf dynamicSettingData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

///动态设置
- (void)dynamicSettingData{
    WS(weakSelf);
    SXNetStaticParam *param = [SXNetStaticParam param];
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    param.dns1 = shareInfo.dns1;
    param.dns2 = shareInfo.dns2;
    [SXAddXiaokiNetTool dynamicSettingWithDataWithParams:param.mj_keyValues Success:^{
        DLog(@"动态校验成功");
        [weakSelf networkStatusData];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    static NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        DLog(@"网络状态正常");
        weakSelf.headerView.netStatus = 0;
    } failure:^(NSError * _Nonnull error) {
        weakSelf.headerView.netStatus = error.code;
        ++count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count%3 != 0) {
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

@end
