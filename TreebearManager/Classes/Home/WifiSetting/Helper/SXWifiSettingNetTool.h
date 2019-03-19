//
//  SXWifiSettingNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXWifiSettingNetTool : NSObject

///重启节点
+ (void)nodeRestartWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///恢复出厂设置
+ (void)nodeResetWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
