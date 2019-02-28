//
//  SXMineNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXMineUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineNetTool : NSObject

///用户信息获取 
+ (void)getUserInfoDataSuccess:(void (^)(SXMineUserInfoModel *model))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
