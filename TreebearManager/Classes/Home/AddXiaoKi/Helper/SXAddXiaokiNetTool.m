//
//  SXAddXiaokiNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/6.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAddXiaokiNetTool.h"
#import "XKNetRequestTool.h"
#import "XKUserMember.h"

@implementation SXAddXiaokiNetTool

+ (void)loginWithPasswdDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [XKNetRequestTool POST:app_login parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        //获取token，保存单利
        NSString *token = [response objectForKey:@"token"];
        XKUserMember.sharedXKUserMember.token = token;
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)broadbandSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [XKNetRequestTool POST:pppoe_set parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)staticSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:static_set parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)dynamicSettingWithDataWithSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:dynamic_set parameters:nil success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)networkStatusWithDataSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:network_status parameters:nil success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)ssidSettingWithDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [XKNetRequestTool POST:ssid_set parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getNodeWithDataWithSuccess:(void (^)(SXXiaoKNodeResult *result))success failure:(void (^)(NSError *error))failure{
    
    [XKNetRequestTool POST:node_get parameters:nil success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        //获取节点信息
        SXXiaoKNodeResult *result = [SXXiaoKNodeResult mj_objectWithKeyValues:response];
        
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
