//
//  SXMessageNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMessageNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXMessageNetTool

+ (void)userMessageListParams:(NSDictionary *)params Success:(void (^)(SXHomeMessageResult *result))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_message_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXHomeMessageResult *result = [SXHomeMessageResult mj_objectWithKeyValues:response];
        
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
