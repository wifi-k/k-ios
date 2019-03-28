//
//  SXWifiSettingNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingNetTool.h"
#import "XKNetRequestTool.h"
#import "SXNetRequestTool.h"

@implementation SXWifiSettingNetTool

+ (void)nodeRestartWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:node_restart parameters:nil success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)nodeResetWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:node_reset parameters:nil success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeDeviceListDataWithParams:(NSDictionary *)params success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_device_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        //获取设备列表
        NSArray *list = [SXPreventModel mj_objectArrayWithKeyValuesArray:response];
        
        if (success){
            success(list);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userDodeDeviceSetDataWithParams:(NSDictionary *)params success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_device_set parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
