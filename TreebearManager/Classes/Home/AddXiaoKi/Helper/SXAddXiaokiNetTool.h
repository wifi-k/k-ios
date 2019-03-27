//
//  SXAddXiaokiNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/6.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXNetStaticParam.h"
#import "SXNetBroadbandParam.h"
#import "SXXiaoKNodeResult.h"
#import "SXXiaoKInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXAddXiaokiNetTool : NSObject

///App登录
+ (void)loginWithPasswdDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///设置宽带账号
+ (void)broadbandSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///设置静态IP参数
+ (void)staticSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///使用动态IP(校验)
+ (void)dynamicSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///查询网络状态
+ (void)networkStatusWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///设置wifi参数
+ (void)ssidSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///获取节点信息
+ (void)getNodeWithDataWithSuccess:(void (^)(SXXiaoKNodeResult *result))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
