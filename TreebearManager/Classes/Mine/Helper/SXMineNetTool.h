//
//  SXMineNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXMineUserInfoParam.h"
#import "SXXiaoKiParam.h"
#import "SXMineUserInfoModel.h"
#import "SXHomeXiaoKiResult.h"
#import "SXHomeXiaoKiSSIDModel.h"
#import "SXMineUserInfoResult.h"

@interface SXMineNetTool : NSObject

///用户信息获取(最新)
+ (void)userInfoGetextDataWithFilter:(NSNumber *)filter Success:(void (^)(SXMineUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

///用户获取七牛token
+ (void)getUserQiniuTokenSuccess:(void (^)(NSString *token))success failure:(void (^)(NSError *error))failure;

///用户信息修改
+ (void)userInfoSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///升级节点固件
+ (void)userNodeFirmwareUpgradeParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///获取节点的ssid列表
+ (void)userNodeWifiListParams:(NSString *)nodeId Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

///设置节点ssid信息
+ (void)userNodeWifiSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///节点信息查询 
+ (void)userNodeListParams:(NSDictionary *)params Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

///节点绑定
+ (void)userNodeBindParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///节点解绑
+ (void)userNodeUnbindParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///节点信息修改
+ (void)userNodeInfoSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///家庭节点列表 (返回自己的节点和所属家庭的节点)
+ (void)userNodeListallParams:(NSDictionary *)params Success:(void (^)(SXHomeXiaoKiResult *result))success failure:(void (^)(NSError *error))failure;

///用户退出
+ (void)userQuitSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

