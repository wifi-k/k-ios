//
//  SXLoginNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXLoginParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXLoginNetTool : NSObject

///获取手机验证码
+ (void)getCodeDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

///用户名手机验证码注册
+ (void)registUserInfoDataWithParams:(NSDictionary *)params Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
