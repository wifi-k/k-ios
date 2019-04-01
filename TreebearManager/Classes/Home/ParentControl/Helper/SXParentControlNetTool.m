//
//  SXParentControlNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXParentControlNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXParentControlNetTool

+ (void)userNodeDeviceAllowListParams:(NSDictionary *)params Success:(void (^)(SXForbiddenAppResult *result))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_device_allow_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXForbiddenAppResult *result = [SXForbiddenAppResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeDeviceAllowSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_device_allow_set parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeDeviceAllowDelParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_device_allow_del parameters:params success:^(id response) {
        
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
