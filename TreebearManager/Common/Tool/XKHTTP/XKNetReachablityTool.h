//
//  XKNetReachablityTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XKNetworkStatus) {
    XKNetworkStatusUnkown = 0,     //未知状态
    XKNetworkStatusWifi = 1,       //有网，Wifi环境
    XKNetworkStatus3G,             //有网，3G环境
    XKNetworkStatusNoNetwork3G,    //无网，但是有3G  这种情况在app退到后台，切换网络，然后打开可现
    XKNetworkStatusNoNetwork,      //无网，无wifi，无3G
};

@interface XKNetReachablityTool : NSObject

+ (void)reachablityStatus:(void (^)(XKNetworkStatus networkStatus))success failure:(void (^)(XKNetworkStatus networkStatus))failure;

+ (BOOL)netWorkAbility;

@end

