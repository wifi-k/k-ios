//
//  SXNetReachablityTool.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SXNetworkStatus) {
    SXNetworkStatusUnkown = 0,     //未知状态
    SXNetworkStatusWifi = 1,       //有网，Wifi环境
    SXNetworkStatus3G = 2,             //有网，3G环境
    SXNetworkStatusNoNetwork3G = 3,    //无网，但是有3G,这种情况在app退到后台，切换网络，然后打开可现
    SXNetworkStatusNoNetwork = 4,      //无网，无wifi，无3G
};

@interface SXNetReachablityTool : NSObject

+ (void)reachablityStatus:(void (^)(SXNetworkStatus networkStatus))success fail:(void (^)(SXNetworkStatus networkStatus))failure;

+ (BOOL)netWorkAbility;

+ (SXNetworkStatus)status;

@end

NS_ASSUME_NONNULL_END
