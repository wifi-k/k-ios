//
//  SXMessageNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHomeMessagePageParam.h"
#import "SXHomeMessageResult.h"

@interface SXMessageNetTool : NSObject

///查询用户消息列表
+ (void)userMessageListParams:(NSDictionary *)params Success:(void (^)(SXHomeMessageResult *result))success failure:(void (^)(NSError *error))failure;

@end
