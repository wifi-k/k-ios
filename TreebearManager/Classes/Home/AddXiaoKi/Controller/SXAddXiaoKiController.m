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
#import "SXNetBroadbandParam.h"
#import "NSString+Hash.h"

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

- (void)getNodeData{
//    WS(weakSelf);
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(NSString * _Nonnull node) {
        DLog(@"获取节点");
        DLog(@"node:%@",node);
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
    
    if (wifiSSID.length > 1) {
        self.headerView.title = [NSString stringWithFormat:@"您已连接wifi名称为'%@'的设备，点击立即绑定设备",wifiSSID];
        self.headerView.hidden = NO;
    } else{
        self.headerView.hidden = YES;
        [self alertOnNetAlertView];
    }
//    if ([wifiSSID containsString:@"Xiaomi"] || [wifiSSID containsString:@"Office"]) {
//        self.headerView.hidden = YES;
//        [self alertOnNetAlertView];
//    } else{
//        self.headerView.hidden = NO;
//    }
}

#pragma mark -网络选择页面-
- (void)jumpToNetOptionVC{
    
    [self networkStatusData];
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    WS(weakSelf);
    __block NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        DLog(@"网络状态正常");
        SXNetOptionController *netVC = [[SXNetOptionController alloc] init];
        [weakSelf.navigationController pushViewController:netVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count++ != 5) {
                [weakSelf networkStatusData];
            }
        });
    }];
}

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
