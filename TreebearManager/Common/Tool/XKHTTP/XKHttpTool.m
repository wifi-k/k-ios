//
//  XKHttpTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "XKHttpTool.h"
#import <AFNetworking/AFNetworking.h>
#import "XKUploadParam.h"
#import "XKUserMember.h"

@implementation XKHttpTool

//发送get请求
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //设置请求参数
    [self setSessionManager:mgr];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];
    
    //修改block的线程
    mgr.completionQueue = dispatch_get_global_queue(0, 0);
    
    [mgr GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


//发送post请求
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{
    
    //创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [self setSessionManager:mgr];
    
    //设置请求基本参数
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];
    
    //修改block的线程
    mgr.completionQueue = dispatch_get_global_queue(0, 0);
    
    [mgr POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//上传请求
+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters upload:(XKUploadParam *)param
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure{
    
    //注意：以后如果一个方法，要传很多参数，就把参数包装成一个模型
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //设置请求参数
    [self setSessionManager:mgr];
    
    //    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];
    
    //修改block的线程
    mgr.completionQueue = dispatch_get_global_queue(0, 0);
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件拼接到formdata
        /*
         FileData:要上传的文件的文件文进制数据
         name:上传参数名称
         filename : 上传到服务器的文件名称
         mimeType: 文件类型
         */
        [formData appendPartWithFileData:param.data name:param.name fileName:param.fileName mimeType:param.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)UPLOAD:(NSString *)URLString
    parameters:(id)parameters
        photos:(NSArray<XKUploadParam *> *)photos success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //设置请求参数
    [self setSessionManager:mgr];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream",nil];
    
    //修改block的线程
    mgr.completionQueue = dispatch_get_global_queue(0, 0);
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //上传的文件全部拼接到formData
        for (int i = 0; i < photos.count; i ++){
            XKUploadParam *uploadParam = photos[i];
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        DLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)setSessionManager:(AFHTTPSessionManager *)manager{
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 160;
    
    //请求的序列化
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //清除头部赋值
    [manager.requestSerializer clearAuthorizationHeader];
    
    //设置请求基本参数
    [manager.requestSerializer  setValue:@"utf-8"  forHTTPHeaderField:@"Accept-Encoding"];
    //[manager.requestSerializer  setValue:@"application/json;charset=utf-8"  forHTTPHeaderField:@"Content－Type"];
    [manager.requestSerializer setValue:@"2019.3.1" forHTTPHeaderField:@"Api-Version"];
    NSString *tokenStr = XKUserMember.sharedXKUserMember.token;
    if ([NSString isNotEmpty:tokenStr]) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Api-Token"];
    }
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    //设置缓存网络请求缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
}

@end
