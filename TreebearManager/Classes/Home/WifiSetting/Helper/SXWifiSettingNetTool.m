//
//  SXWifiSettingNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingNetTool.h"
#import "XKNetRequestTool.h"

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

@end
