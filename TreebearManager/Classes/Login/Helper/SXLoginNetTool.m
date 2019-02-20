//
//  SXLoginNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginNetTool.h"
#import "SXNetRequestTool.h"
#import "SXUserArchiveTool.h"

@implementation SXLoginNetTool

+ (void)getCodeDataWithParams:(NSDictionary *)params Success:(void (^)(NSString *code))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_vcode_getv2 parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSString.class]) return;
        
        if (success){
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)registUserInfoDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_signup_vcode parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        //获取token，保存本地
        NSString *token = [response objectForKey:@"token"];
        SXUserArchiveTool.user.token = token;
        [SXUserArchiveTool saveUser];
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginWithVCodeDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_signin_vcode parameters:params success:^(id response) {
        
        //获取token，保存本地
        NSString *token = [response objectForKey:@"token"];
        SXUserArchiveTool.user.token = token;
        [SXUserArchiveTool saveUser];
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)resetPasswdDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_passwd_reset parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginWithPasswordDataWithParams:(NSDictionary *)params Success:(void (^)(NSString *code))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_signin_passwd parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        NSString *token = [response objectForKey:@"token"];
        if (success){
            success(token);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
