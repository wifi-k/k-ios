//
//  XKNetRequestTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XKHttpTool.h"

@interface XKNetRequestTool : NSObject

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
   uploadParam:(XKUploadParam *)uploadParam
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure;

+ (void)UPLOAD:(NSString *)path
    parameters:(id)parameters
        photos:(NSArray<XKUploadParam *> *)photos
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure;

@end

