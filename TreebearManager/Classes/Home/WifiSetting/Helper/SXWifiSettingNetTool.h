//
//  SXWifiSettingNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXPreventPageParam.h"
#import "SXMobilePageParam.h"
#import "SXPreventModel.h"
#import "SXMobileManagerResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXWifiSettingNetTool : NSObject

///重启节点
+ (void)nodeRestartWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///恢复出厂设置
+ (void)nodeResetWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///获取上网设备列表
+ (void)userNodeDeviceListDataWithParams:(NSDictionary *)params success:(void (^)(SXMobileManagerResult *result))success failure:(void (^)(NSError *error))failure;

///获取上网设备列表
+ (void)userDodeDeviceSetDataWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
