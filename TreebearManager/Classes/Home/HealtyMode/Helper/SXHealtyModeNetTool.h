//
//  SXHealtyModeNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHealtyControlResult.h"
#import "SXHealtyControlParam.h"

@interface SXHealtyModeNetTool : NSObject

///获取信号定时配置
+ (void)userNodeWifiTimerGetDataWithParams:(NSDictionary *)params Success:(void (^)(SXHealtyControlResult *result))success failure:(void (^)(NSError *error))failure;

///设置信号当时配置
+ (void)userNodeWifiTimerSetDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end
