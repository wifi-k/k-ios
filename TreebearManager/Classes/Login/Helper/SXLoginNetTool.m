//
//  SXLoginNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginNetTool.h"
#import "SXNetRequestTool.h"
#import <YYKit/NSObject+YYModel.h>

@implementation SXLoginNetTool

+ (void)getCodeDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_vcode_getv2 parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)registUserInfoDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_vcode_getv2 parameters:params success:^(id response) {
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
