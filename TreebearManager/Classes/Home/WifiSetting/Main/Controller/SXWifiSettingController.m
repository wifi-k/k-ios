//
//  SXWifiSettingController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingController.h"
#import "SXPreventController.h"
#import "SXAdvancedController.h"
#import "SXOnlineController.h"
#import "SXLANPortController.h"
#import "SXDHCPServerController.h"
#import "SXWifiSettingHeaderView.h"
#import "SXWifiSettingAlertView.h"
#import "SXTitleAlertView.h"
#import "SXWarningAlertView.h"
#import "SXWifiSettingNetTool.h"
#import "SXAddXiaokiNetTool.h"
#import "SXXiaoKInfoModel.h"
#import "SXMineNetTool.h"
#import "NSString+Hash.h"
#import "XKGetWifiNetTool.h"
#import "SXDynamicParam.h"
#import "SXRootTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXWifiSettingController ()
@property (nonatomic, weak) SXWifiSettingHeaderView *headerView;//头部视图
@end

@implementation SXWifiSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
    
    //获取节点数据
    [self getNodeData];
    
    //获取wifi列表
    [self userNodeWifiListData];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"WiFi工具箱";
    
    //2.头部视图
    WS(weakSelf);
    SXWifiSettingHeaderView *headerView = [SXWifiSettingHeaderView headerView];
    headerView.clickWifiNameBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickWifiPasswordBlock = ^{
        [weakSelf alertUpdatePwdView];
    };
    headerView.clickAdvancedBtnBlock = ^(NSInteger tag) {
        [weakSelf jumpToSettingVC:tag];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        SXXiaoKiParam *param = [SXXiaoKiParam param];
        param.nodeId = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId;
        param.freq = @0;
        param.ssid = text;
        [weakSelf userNodeSsidSetDataWitiParam:param];
    };
    [nameAlertView alert];
}

- (void)alertUpdatePwdView{
    WS(weakSelf);
    SXWifiSettingAlertView *pwdAlertV = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的密码" confirmStr:@"确定" cancelStr:@"取消"];
    pwdAlertV.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        SXXiaoKiParam *param = [SXXiaoKiParam param];
        param.nodeId = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId;
        param.freq = @0;
        param.passwd = text.md5String;
        [weakSelf userNodeSsidSetDataWitiParam:param];
    };
    [pwdAlertV alert];
}

#pragma mark -页面跳转-
- (void)jumpToSettingVC:(NSInteger)tag{
    WS(weakSelf);
    switch (tag) {
        case 0:{
            SXPreventController *preventVC = [[SXPreventController alloc] init];
            [self.navigationController pushViewController:preventVC animated:YES];
        }
            break;
        case 1:{
            if ([NSString isEmpty:SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId]) {
                [MBProgressHUD showWarningWithMessage:@"请检查您的WiFi连接" toView:SXKeyWindow];
                return;
            }
            SXOnlineController *advancedVC = [[SXOnlineController alloc] init];
            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 2:{
            
            SXWarningAlertView *netAlertView = [SXWarningAlertView alertWithTitle:@"请确认是否重启" content:@"路由器重启预计需要几分钟时间，重启过程中，所有已连设备会断开连接" confirmStr:@"确定" cancelStr:@"取消"];
            netAlertView.confirmButtonBlock = ^{
                [weakSelf nodeRestartWithData];
            };
            netAlertView.cancelButtonBlock = ^{
                
            };
            [netAlertView alert];
        }
            break;
        case 3:{
            SXWarningAlertView *netAlertView = [SXWarningAlertView alertWithTitle:@"请确认是否恢复出厂设置" content:@"路由器的所有配置将恢复至出厂时的默认状态" confirmStr:@"确定" cancelStr:@"取消"];
            netAlertView.confirmButtonBlock = ^{
                [weakSelf nodeResetWithData];
            };
            netAlertView.cancelButtonBlock = ^{
                
            };
            [netAlertView alert];

        }
            break;
        case 4:{
            
//            SXLANPortController *advancedVC = [[SXLANPortController alloc] init];
//            [self.navigationController pushViewController:advancedVC animated:YES];
            //SXRestartController *advancedVC = [[SXRestartController alloc] init];
            //[self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 5:{
//            SXDHCPServerController *advancedVC = [[SXDHCPServerController alloc] init];
//            [self.navigationController pushViewController:advancedVC animated:YES];
        }
            break;
        case 6:{
            DLog(@"tag:%ld",tag);
        }
            break;
        case 7:
            DLog(@"tag:%ld",tag);
            break;
        default:
            break;
    }
}

#pragma mark -视图弹窗-
- (void)alertOnNetAlertView{
    SXTitleAlertView *netAlertView = [SXTitleAlertView alertWithTitle:@"连网提示" content:@"请前往手机系统设置,重新连接WiFi" confirmStr:@"确定" cancelStr:@"取消"];
    netAlertView.confirmButtonBlock = ^{
        [SXRootTool jumpToSystemWIFI];
    };
    netAlertView.cancelButtonBlock = ^{
        DLog(@"点击取消!");
    };
    [netAlertView alert];
}

#pragma mark -WiFi列表数据接口-
- (void)userNodeWifiListData{
    NSString *nodeId = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.nodeId;
    if ([NSString isEmpty:nodeId]) {
        [MBProgressHUD showWarningWithMessage:@"没有获取到设备，请检查您的WiFi连接" toView:SXKeyWindow];
        return;
    }
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeWifiListParams:nodeId Success:^(NSArray *array) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        //赋值
        DLog(@"array:%@",array);
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -WiFi设置数据接口-
- (void)userNodeSsidSetDataWitiParam:(SXXiaoKiParam *)param{
    if ([NSString isEmpty:SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId]) {
        [MBProgressHUD showWarningWithMessage:@"没有修改成功，请检查您的WiFi连接" toView:SXKeyWindow];
        return;
    }
    
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeWifiSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        //赋值
        SXXiaoKInfoModel.sharedSXXiaoKInfoModel.name = param.ssid;
        [weakSelf.headerView setUpData];
        //设置成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:SXKeyWindow];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -网络信息设置-
- (void)setNetDynamicData{
    WS(weakSelf);
    SXDynamicParam *param = [SXDynamicParam param];
    param.ssid0 = [XKGetWifiNetTool getWifiSSID];
    param.ssid = @"";
    param.passwd = @"".md5String;
    [SXAddXiaokiNetTool ssidSettingWithDataWithParams:param.mj_keyValues Success:^{
        //1.指示器
        [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:weakSelf.view];
        //2.WiFi名称已经更改，前往系统设置重新连接
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf alertOnNetAlertView];
        });
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -获取节点数据-
- (void)getNodeData{
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        DLog(@"获取节点");
        //1.更新wan信息
        SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
        [shareInfo setDataWithResult:result];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -重启节点设置-
- (void)nodeRestartWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"重启中..." toView:self.view];
    [SXWifiSettingNetTool nodeRestartWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"重启节点OK!");
        [MBProgressHUD showMessage:@"重启节点OK!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -恢复出厂设置-
- (void)nodeResetWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"恢复中..." toView:self.view];
    [SXWifiSettingNetTool nodeResetWithDataSuccess:^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        DLog(@"恢复出厂设置OK!");
        [MBProgressHUD showMessage:@"恢复出厂设置OK!" toView:weakSelf.view];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
