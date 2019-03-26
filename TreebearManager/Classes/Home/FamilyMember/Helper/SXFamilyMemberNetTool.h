//
//  SXFamilyMemberNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXFamilyMemberParam.h"
#import "SXFamilyMemberModel.h"

@interface SXFamilyMemberNetTool : NSObject

///加入家庭
+ (void)userNodeFamilyJoinDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///家庭成员列表
+ (void)userNodeFamilyListDataWithParams:(NSDictionary *)params Success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure;

///修改家庭成员信息
+ (void)userNodeFamilySetDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///删除家庭成员
+ (void)userNodeFamilyQuitDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///节点加入共享计划
+ (void)userNodeShareJoinDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///离开共享计划
+ (void)userNodeShareQuitDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///用户选定节点
+ (void)userNodeSelectDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

