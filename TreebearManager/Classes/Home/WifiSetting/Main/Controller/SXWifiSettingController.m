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

///节点信息结果模型
@property (nonatomic, strong) SXXiaoKNodeResult *result;
@end

@implementation SXWifiSettingController

#pragma mark -getter-
- (SXXiaoKNodeResult *)result{
    if (_result == nil) {
        _result = [[SXXiaoKNodeResult alloc] init];
    }
    return _result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
    
    //获取节点数据
    [self getNodeData];
    
    //获取wifi列表
    [self userNodeWifiListData];
    
    //添加通知
    [self addNotification];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"WiFi工具箱";
    
    //2.头部视图
    WS(weakSelf);
    SXWifiSettingHeaderView *headerView = [SXWifiSettingHeaderView headerView];
    headerView.clickWifiNameBlock = ^{
        if (![weakSelf isNearWifi]) {
            [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
            return;
        }
        
        [weakSelf alertUpdateNameView];
    };
    headerView.clickWifiPasswordBlock = ^{
        if (![weakSelf isNearWifi]) {
            [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
            return;
        }
        
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

- (void)addNotification{
    // app从后台进入前台都会调用这个方法
    [SXNotificationCenter addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)dealloc{
    [SXNotificationCenter removeObserver:self];
}

- (void)applicationBecomeActive{
    [self getNodeData];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        if ([weakSelf isNearWifi]) {
            SXDynamicParam *param = [SXDynamicParam param];
            param.ssid0 = [XKGetWifiNetTool getWifiSSID];
            param.ssid = text;
            //param.passwd = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.passwd;
            [weakSelf setNetDynamicData:param];
        } else {
            [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
//            SXXiaoKiParam *param = [SXXiaoKiParam param];
//            param.nodeId = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.nodeId;
//            param.freq = @0;
//            param.ssid = text;
//            [weakSelf userNodeSsidSetDataWitiParam:param];
        }
    };
    [nameAlertView alert];
}

- (void)alertUpdatePwdView{
    WS(weakSelf);
    SXWifiSettingAlertView *pwdAlertV = [SXWifiSettingAlertView alertWithTitle:@"设置WiFi名称" placeholder:@"请输入新的密码" confirmStr:@"确定" cancelStr:@"取消"];
    pwdAlertV.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        if (text.length < 8) {
            [MBProgressHUD showWarningWithMessage:@"密码长度不得低于8位!" toView:SXKeyWindow];
            return;
        }
        if (text.length > 20) {
            [MBProgressHUD showWarningWithMessage:@"密码长度不得大于20位!" toView:SXKeyWindow];
            return;
        }
        if ([weakSelf isNearWifi]) {
            SXDynamicParam *param = [SXDynamicParam param];
            param.ssid0 = [XKGetWifiNetTool getWifiSSID];
            param.passwd = text;
            [weakSelf setNetDynamicData:param];
        } else {
            [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
//            SXXiaoKiParam *param = [SXXiaoKiParam param];
//            param.nodeId = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.nodeId;
//            param.freq = @0;
//            param.passwd = text.md5String;
//            [weakSelf userNodeSsidSetDataWitiParam:param];
        }
    };
    [pwdAlertV alert];
}

#pragma mark -判断是否使用近网通信-
- (BOOL)isNearWifi{
    if ([NSString isEmpty:self.result.modelId]) {
        return NO;
    }
    return YES;
//    NSString *nearNodeId = [SXXiaoKInfoModel sharedSXXiaoKInfoModel].modelId;
//    NSString *farNodeId = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.nodeId;
//    return [nearNodeId isEqualToString:farNodeId];
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
            if (![self isNearWifi]) {
                [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
                return;
            }
            
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
            if (![self isNearWifi]) {
                [MBProgressHUD showWarningWithMessage:@"请先连接您的小K设备!" toView:SXKeyWindow];
                return;
            }
            
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

#pragma mark -获取节点数据-
- (void)getNodeData{
    WS(weakSelf);
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        DLog(@"获取节点");
        weakSelf.result = result;
        //更新wan信息
        SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
        [shareInfo setDataWithResult:result];
        //更改文案
        [weakSelf.headerView setUpData];
    } failure:^(NSError * _Nonnull error) {
        if (error.code != 0) {
            DLog(@"token失效");
        }
    }];
}

#pragma mark -WiFi列表数据接口-
- (void)userNodeWifiListData{
    NSString *nodeId = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.nodeId;
    if ([NSString isEmpty:nodeId]) {
        [MBProgressHUD showWarningWithMessage:@"没有获取到设备，请检查您的WiFi连接" toView:SXKeyWindow];
        return;
    }
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeWifiListParams:nodeId Success:^(NSArray *array) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        //赋值
        DLog(@"array:%@",array);
        
        if (!array.count) return;
        
        for (SXHomeXiaoKiSSIDModel *ssidModel in array) {
            if ([ssidModel.nodeId isEqualToString:nodeId]) {
                [weakSelf.headerView setUpData];
                break;
            }
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -WiFi设置数据接口-
- (void)userNodeSsidSetDataWitiParam:(SXXiaoKiParam *)param{
    if ([NSString isEmpty:SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId]) {
        [MBProgressHUD showWarningWithMessage:@"修改失败，请检查您的WiFi连接!" toView:SXKeyWindow];
        return;
    }
    
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeWifiSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        //赋值;
        [weakSelf.headerView setUpData];
        //设置成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:SXKeyWindow];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -网络信息设置-
- (void)setNetDynamicData:(SXDynamicParam *)param{
    WS(weakSelf);
    [SXAddXiaokiNetTool ssidSettingWithDataWithParams:param.mj_keyValues Success:^{
        //1.指示器
        [MBProgressHUD showSuccessWithMessage:@"WiFi设置成功!" toView:weakSelf.view];
        //2.WiFi名称已经更改，前往系统设置重新连接
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf alertOnNetAlertView];
        });
    } failure:^(NSError * _Nonnull error) {
        if (error.code != 0) {
            DLog(@"token失效");
        }
    }];
}

#pragma mark -重启节点设置-
- (void)nodeRestartWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"重启中..." toView:SXKeyWindow];
    [SXWifiSettingNetTool nodeRestartWithDataSuccess:^{
        DLog(@"重启节点OK!");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:@"重启节点OK!" toView:weakSelf.view];
                [weakSelf alertOnNetAlertView];
            });
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
            [weakSelf alertOnNetAlertView];
//            NSString *message = [error.userInfo objectForKey:@"msg"];
//            if ([NSString isNotEmpty:message]) {
//                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
//            }
        });
    }];
}

#pragma mark -恢复出厂设置-
- (void)nodeResetWithData{
    WS(weakSelf);
    [MBProgressHUD showWhiteLoadingWithMessage:@"恢复中..." toView:SXKeyWindow];
    [SXWifiSettingNetTool nodeResetWithDataSuccess:^{
        DLog(@"恢复出厂设置OK!");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:@"恢复出厂设置OK!" toView:weakSelf.view];
                [weakSelf alertOnNetAlertView];
            });
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(120.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
            [weakSelf alertOnNetAlertView];
//            NSString *message = [error.userInfo objectForKey:@"msg"];
//            if ([NSString isNotEmpty:message]) {
//                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
//            }
        });
    }];
}

@end
