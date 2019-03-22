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

+ (void)getUserQiniuTokenSuccess:(void (^)(NSString *token))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_qiniu_get parameters:nil success:^(id response) {
        
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

+ (void)userInfoSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_info_set parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeFirmwareUpgradeParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.nodeId = nodeId;
    [SXNetRequestTool POST:user_node_firmware_upgrade parameters:param.mj_keyValues success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeSsidListSuccess:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_node_ssid_list parameters:nil success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        NSArray *pageList = [response objectForKey:@"page"];
        
        NSArray *modelList = [SXHomeXiaoKiModel mj_objectArrayWithKeyValuesArray:pageList];
        
        if (success){
            success(modelList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeBindParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.nodeId = nodeId;
    [SXNetRequestTool POST:user_node_bind parameters:param.mj_keyValues success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeUnbindParams:(NSString *)nodeId Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.nodeId = nodeId;
    [SXNetRequestTool POST:user_node_unbind parameters:param.mj_keyValues success:^(id response) {
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
