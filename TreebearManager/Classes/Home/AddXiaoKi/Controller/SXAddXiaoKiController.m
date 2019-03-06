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
#import "XKGetWifiNetTool.h"
#import "SXRootTool.h"

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
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)dealloc{
    [SXNotificationCenter removeObserver:self];
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
#warning mark -更换正式-
//    if ([wifiSSID containsString:@"Xiaomi"] || [wifiSSID containsString:@"Office"]) {
//        self.headerView.hidden = NO;
//    } else{
//        self.headerView.hidden = YES;
//        [self alertOnNetAlertView];
//    }
    if ([wifiSSID containsString:@"Xiaomi"] || [wifiSSID containsString:@"Office"]) {
        self.headerView.hidden = YES;
        [self alertOnNetAlertView];
    } else{
        self.headerView.hidden = NO;
    }
}

#pragma mark -跳转网络选择页面-
- (void)jumpToNetOptionVC{
    SXNetOptionController *netVC = [[SXNetOptionController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
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
        SXSingleAlertView *singleAV = [SXSingleAlertView alertWithTitle:@"连网提示" content:@"请立即连接wifi名称为'xiaoki-xxxx',然后再绑定设备" confirmStr:@"确定"];
        singleAV.confirmButtonBlock = ^{
            [SXRootTool jumpToSystemWIFI];
        };
        [singleAV alert];

        /*
        SXTitleAlertView *netAlertView = [SXTitleAlertView alertWithTitle:@"连网提示" content:@"请立即连接wifi名称为'xiaoki-xxxx',然后再绑定设备" confirmStr:@"确定" cancelStr:@"取消"];
        netAlertView.confirmButtonBlock = ^{
            [SXRootTool jumpToSystemWIFI];
        };
        netAlertView.cancelButtonBlock = ^{
            [SXRootTool popToPrevious];
        };
        [netAlertView alert];*/
    }
}

@end
