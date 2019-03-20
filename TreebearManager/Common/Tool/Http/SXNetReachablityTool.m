//
//  SXNetReachablityTool.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetReachablityTool.h"
#import <AFNetworking.h>

static SXNetworkStatus _networkStatus;

@implementation SXNetReachablityTool

+ (void)reachablityStatus:(void (^)(SXNetworkStatus networkStatus))success fail:(void (^)(SXNetworkStatus networkStatus))failure{
    
    //创建一个网络监听器（单例manager）
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DLog(@"没有网络");
                if (failure) {
                    _networkStatus = SXNetworkStatusUnkown;
                    failure(SXNetworkStatusUnkown);
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                DLog(@"连接到路由器网络不能到达");
                if (failure) {
                    _networkStatus = SXNetworkStatusNoNetwork;
                    failure(SXNetworkStatusNoNetwork);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                DLog(@"2G/3G/4G");
                if (success) {
                    _networkStatus = SXNetworkStatus3G;
                    success(SXNetworkStatus3G);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"wifi");
                if (success) {
                    _networkStatus = SXNetworkStatusWifi;
                    success(SXNetworkStatusWifi);
                }
                break;
            default:
                DLog(@"默认未知网络状态");
                if (failure) {
                    _networkStatus = SXNetworkStatusUnkown;
                    failure(SXNetworkStatusUnkown);
                }
                break;
        }
    }];
    //开启检测
    [manager startMonitoring];
}

+ (BOOL)netWorkAbility{
    if (_networkStatus == SXNetworkStatus3G || _networkStatus == SXNetworkStatusWifi) {
        return YES;
    }else{
        return NO;
    }
}

+ (SXNetworkStatus)status{
    return _networkStatus;
}

@end
