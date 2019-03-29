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

+ (void)userInfoGetextDataWithFilter:(NSNumber *)filter Success:(void (^)(SXMineUserInfoResult *result))success failure:(void (^)(NSError *error))failure{
    SXMineUserInfoParam *param = [SXMineUserInfoParam param];
    param.filter = filter;
    [SXNetRequestTool POST:user_info_getext parameters:param.mj_keyValues success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXMineUserInfoResult *result = [SXMineUserInfoResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
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

+ (void)userNodeWifiListParams:(NSString *)nodeId Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.nodeId = nodeId;
    [SXNetRequestTool POST:user_node_wifi_list parameters:param.mj_keyValues success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        NSArray *pageList = [response objectForKey:@"page"];
        
        NSArray *modelList = [SXHomeXiaoKiSSIDModel mj_objectArrayWithKeyValuesArray:pageList];
        
        if (success){
            success(modelList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeWifiSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
   
    [SXNetRequestTool POST:user_node_wifi_set parameters:params success:^(id response) {
        
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeListParams:(NSDictionary *)params Success:(void (^)(SXHomeXiaoKiResult *result))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_node_list parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;

        SXHomeXiaoKiResult *result = [SXHomeXiaoKiResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
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

+ (void)userNodeInfoSetParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    [SXNetRequestTool POST:user_node_info_set parameters:params success:^(id response) {
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userNodeListallParams:(NSDictionary *)params Success:(void (^)(SXHomeXiaoKiResult *result))success failure:(void (^)(NSError *error))failure{

    [SXNetRequestTool POST:user_node_listall parameters:params success:^(id response) {
        
        if (![response isKindOfClass:NSDictionary.class]) return;
        
        SXHomeXiaoKiResult *result = [SXHomeXiaoKiResult mj_objectWithKeyValues:response];
        
        if (success){
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userQuitSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    [SXNetRequestTool POST:user_quit parameters:nil success:^(id response) {
        
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
