//
//  SXHttpTool.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SXUploadParam;

NS_ASSUME_NONNULL_BEGIN

@interface SXHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 *  上传单张图片请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param param 请求的单张图片
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters upload:(SXUploadParam *)param
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

/**
 *  上传多张图片请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param photos 请求的图片数组
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters
        photos:(NSArray<SXUploadParam *> *)photos success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
