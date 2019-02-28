//
//  SXMineNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXMineNetTool

+ (void)getUserInfoDataSuccess:(void (^)(SXMineUserInfoModel *model))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_info_get parameters:nil success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXMineUserInfoModel *model = [SXMineUserInfoModel mj_objectWithKeyValues:response];
        
        if (success){
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
