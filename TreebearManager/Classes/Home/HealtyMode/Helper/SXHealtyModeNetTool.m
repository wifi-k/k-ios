//
//  SXHealtyModeNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyModeNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXHealtyModeNetTool

+ (void)userNodeWifiTimerGetDataWithParams:(NSDictionary *)params Success:(void (^)(SXHealtyControlResult *result))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_wifi_timer_get parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXHealtyControlResult *result = [SXHealtyControlResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeWifiTimerSetDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_wifi_timer_set parameters:params success:^(id response) {
        
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
