//
//  AppDelegate.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "AppDelegate.h"
#import "SXRootTool.h"
#import "SXNetReachablityTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //设置背景色
    self.window.backgroundColor = [UIColor whiteColor];
    //显示窗口
    [self.window makeKeyAndVisible];
    //选择根控制器
//    [SXRootTool chooseRootWithTabBarVC:self.window];
    [SXRootTool chooseRootWithMainLoginVC:self.window];
    
    //监听网络状态
    [self reachablityStatus];
    
    return YES;
}


#pragma mark -监听网络状态-
- (void)reachablityStatus{
    WS(weakSelf);
    [SXNetReachablityTool reachablityStatus:^(SXNetworkStatus networkStatus) {
        switch (networkStatus) {
            case SXNetworkStatus3G:
                DLog(@"当前网络是蜂窝数据!");
                break;
            case SXNetworkStatusWifi:
                DLog(@"当前网络是无线WIFI!");
                break;
            default:
                DLog(@"当前网络状态未知!");
                break;
        }
    } fail:^(SXNetworkStatus networkStatus) {
        [MBProgressHUD showWarningWithMessage:@"当前网络不可用，请检查您的手机数据/Wifi是否开启！" toView:weakSelf.window];
    }];
}

@end
