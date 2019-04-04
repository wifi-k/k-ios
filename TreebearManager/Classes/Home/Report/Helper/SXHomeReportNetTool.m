//
//  SXHomeReportNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXHomeReportNetTool

+ (void)userNodeDeviceWeekListParams:(NSDictionary *)params Success:(void (^)(SXHomeReportResult *result))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_node_device_week_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXHomeReportResult *result = [SXHomeReportResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
