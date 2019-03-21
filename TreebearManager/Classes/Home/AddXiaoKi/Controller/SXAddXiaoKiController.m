//
//  SXAddXiaoKiController.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAddXiaoKiController.h"
#import "SXNetOptionController.h"
#import "SXAddXiaoKiHeaderView.h"
#import "SXSingleAlertView.h"
#import "SXTitleAlertView.h"
#import "XKGetWifiNetTool.h"
#import "SXAddXiaokiNetTool.h"
#import "SXRootTool.h"
#import "NSString+Hash.h"
#import "SXXiaoKInfoModel.h"
#import "SXNetReachablityTool.h"

@interface SXAddXiaoKiController ()
///头部视图
@property (nonatomic, weak) SXAddXiaoKiHeaderView *headerView;
@end

@implementation SXAddXiaoKiController

#pragma mark -life recycle-
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //1.获取当前连接wifi信息
    [self getWifiInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1.初始化UI
    [self setUpUI];
    
    // app启动或者app从后台进入前台都会调用这个方法
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    // app从后台进入前台都会调用这个方法
    [SXNotificationCenter addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"小K添加";
    
    WS(weakSelf);
    SXAddXiaoKiHeaderView *headerView = [SXAddXiaoKiHeaderView headerView];
    headerView.clickConfirmBtnBlock = ^{
        [weakSelf jumpToNetOptionVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.headerView.hidden = YES;
    
    //尝试登录
    [self loginWithData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)dealloc{
    [SXNotificationCenter removeObserver:self];
}

#pragma mark -Net-
- (void)loginWithData{
    //1.尝试登录
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = @"admin";
    param.passwd = @"123456".md5String;
    [SXAddXiaokiNetTool loginWithPasswdDataWithParams:param.mj_keyValues Success:^{
        DLog(@"登录成功!");
        [weakSelf getNodeData];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -获取节点数据-
- (void)getNodeData{
//    WS(weakSelf);
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
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
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -事件监听-
- (void)applicationBecomeActive{
    //1.获取当前连接wifi信息
    [self getWifiInfo];
}

#pragma mark -获取当前连接wifi信息-
- (void)getWifiInfo{
    NSString *wifiSSID = [XKGetWifiNetTool getWifiSSID];
    DLog(@"wifi:%@",wifiSSID);
    
    if (SXNetReachablityTool.status == SXNetworkStatusWifi) {
        self.headerView.title = [NSString stringWithFormat:@"您已连接wifi名称为'%@'的设备，点击立即绑定设备",wifiSSID];
        self.headerView.hidden = NO;
        
        //重新连接之后，更新节点信息
        [self getNodeData];
    } else{
        self.headerView.hidden = YES;
        [self alertOnNetAlertView];
    }
}

#pragma mark -网络选择页面-
- (void)jumpToNetOptionVC{
    SXNetOptionController *netVC = [[SXNetOptionController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
}

#pragma mark -查询网络状态-
//- (void)networkStatusData{
//    WS(weakSelf);
//    static NSInteger count = 0;
//    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
//        DLog(@"网络状态正常");
//    } failure:^(NSError * _Nonnull error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //递归方法
//            if (error.code == 1 && count++ != 5) {
//                [weakSelf networkStatusData];
//            }
//        });
//    }];
//}

#pragma mark -视图弹窗-
- (void)alertOnNetAlertView{
    
    BOOL isContainsAlert = NO;
    for (UIView *v in SXDelegateWindow.subviews) {
        if ([v isKindOfClass:SXSingleAlertView.class]) {
            isContainsAlert = YES;
            break;
        }
    }
    
    if (!isContainsAlert) {
        /*
        SXSingleAlertView *singleAV = [SXSingleAlertView alertWithTitle:@"连网提示" content:@"请立即连接wifi名称为'xiaoki-xxxx',然后再绑定设备" confirmStr:@"确定"];
        singleAV.confirmButtonBlock = ^{
            [SXRootTool jumpToSystemWIFI];
        };
        [singleAV alert];
         */
        
        SXTitleAlertView *netAlertView = [SXTitleAlertView alertWithTitle:@"连网提示" content:@"请立即连接wifi名称为'xiaoki-xxxx',然后再绑定设备" confirmStr:@"确定" cancelStr:@"取消"];
        netAlertView.confirmButtonBlock = ^{
            [SXRootTool jumpToSystemWIFI];
        };
        netAlertView.cancelButtonBlock = ^{
            [SXRootTool popToPrevious];
        };
        [netAlertView alert];
    }
}

@end
