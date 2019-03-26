//
//  SXFamilyMemberNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberNetTool.h"
#import "SXNetRequestTool.h"

@implementation SXFamilyMemberNetTool

+ (void)userNodeFamilyJoinDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_family_join parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeFamilyListDataWithParams:(NSDictionary *)params Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_family_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        NSArray *pageList = [response objectForKey:@"page"];
        
        NSArray *modelList = [SXFamilyMemberModel mj_objectArrayWithKeyValuesArray:pageList];

        if (success){
            success(modelList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeFamilySetDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_family_set parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeFamilyQuitDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_family_quit parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeShareJoinDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_share_join parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeShareQuitDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_share_quit parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeSelectDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_select parameters:params success:^(id response) {
        
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
