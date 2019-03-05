//
//  XKNetReachablityTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "XKNetReachablityTool.h"
#import <AFNetworking.h>

static XKNetworkStatus _networkStatus;

@implementation XKNetReachablityTool

+ (void)reachablityStatus:(void (^)(XKNetworkStatus networkStatus))success failure:(void (^)(XKNetworkStatus networkStatus))failure{
    
    //创建一个网络监听器（单例manager）
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLog(@"没有网络");
                if (failure) {
                    _networkStatus = XKNetworkStatusUnkown;
                    failure(XKNetworkStatusUnkown);
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DLog(@"连接到路由器网络不能到达");
                if (failure) {
                    _networkStatus = XKNetworkStatusNoNetwork;
                    failure(XKNetworkStatusNoNetwork);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"2G/3G/4G");
                if (success) {
                    _networkStatus = XKNetworkStatus3G;
                    success(XKNetworkStatus3G);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"wifi");
                if (success) {
                    _networkStatus = XKNetworkStatusWifi;
                    success(XKNetworkStatusWifi);
                }
                break;
            default:
                DLog(@"默认未知网络状态");
                if (failure) {
                    _networkStatus = XKNetworkStatusUnkown;
                    failure(XKNetworkStatusUnkown);
                }
                break;
        }
    }];
    //开启检测
    [manager startMonitoring];
}

+ (BOOL)netWorkAbility{
    if (_networkStatus == XKNetworkStatus3G || _networkStatus == XKNetworkStatusWifi) {
        return YES;
    }else{
        [MBProgressHUD showWarningWithMessage:@"当前网络不可用，请检查您的手机数据/Wifi是否开启！" toView:SXKeyWindow];
        return NO;
    }
}

@end
