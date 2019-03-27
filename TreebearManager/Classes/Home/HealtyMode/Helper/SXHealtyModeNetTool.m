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

+ (void)userNodeRssiTimerListDataWithParams:(NSDictionary *)params Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_rssi_timer_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        NSArray *pageList = [response objectForKey:@"page"];
        
        NSArray *modelList = [SXHealtyControlResult mj_objectArrayWithKeyValuesArray:pageList];
        
        if (success){
            success(modelList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeRssiTimerSetDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_rssi_timer_set parameters:params success:^(id response) {
        
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
