//
//  SXParentControlNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXForbiddenAppParam.h"
#import "SXForbiddenAppResult.h"

@interface SXParentControlNetTool : NSObject

///获取设备上网配置列表
+ (void)userNodeDeviceAllowListParams:(NSDictionary *)params Success:(void (^)(SXForbiddenAppResult *result))success failure:(void (^)(NSError *error))failure;

///设置设备允许上网配置
+ (void)userNodeDeviceAllowSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///删除设备上网配置
+ (void)userNodeDeviceAllowDelParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end
