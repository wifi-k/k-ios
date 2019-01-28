//
//  SXNetRequestTool.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHttpTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNetRequestTool : NSObject

+ (void)GET:(NSString *)path
 parameters:(id)parameters
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)path
  parameters:(id)parameters
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))failure;

+ (void)UPLOAD:(NSString *)path
    parameters:(id)parameters
   uploadParam:(SXUploadParam *)uploadParam
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure;

+ (void)UPLOAD:(NSString *)path
    parameters:(id)parameters
        photos:(NSArray<SXUploadParam *> *)photos
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
