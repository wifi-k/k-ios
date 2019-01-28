
//
//  SXNetRequestTool.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetRequestTool.h"

#ifdef DEBUG
#define API_HOST @"https://testpay.hongnaga.com/app" //主测试环境
#else
#define API_HOST @"https://testpay.hongnaga.com/app" //主线上环境
#endif

/** 接收消息提示(0,成功) **/
static NSString * const kResultMessage = @"message";
/** 接收数据体(获取成功) **/
static NSString * const kResultContent = @"data";
/** 状态码{"pageindex": 1,"pagesize": 2,} **/
static NSString * const kResultCode = @"code";


@implementation SXNetRequestTool

+ (void)GET:(NSString *)path
 parameters:(id)parameters
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))failure{
    
    NSString *requestPath = [NSString stringWithFormat:@"%@/%@",API_HOST,path];
    
    [SXHttpTool GET:requestPath parameters:parameters success:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:kResultCode];
        NSString *codeStr = code.description;
        if ([self validateWithStr:codeStr]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success([responseObject objectForKey:kResultContent]);
                }
            });
        }else{
            NSString *resultMessage = [responseObject objectForKey:kResultMessage];
            if(resultMessage == nil){
                resultMessage = @"未知错误!";
            }
            NSError *error =[NSError errorWithDomain:resultMessage code:codeStr.integerValue userInfo:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

+ (void)POST:(NSString *)path
  parameters:(id)parameters
     success:(void (^)(id response))success
     failure:(void (^)(NSError *error))failure{
    
    NSString *requestPath = [NSString stringWithFormat:@"%@/%@",API_HOST,path];
    
    [SXHttpTool POST:requestPath parameters:parameters success:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:kResultCode];
        NSString *codeStr = code.description;
        if ([self validateWithStr:codeStr]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success([responseObject objectForKey:kResultContent]);
                }
            });
        }else{
            NSString *resultMessage = [responseObject objectForKey:kResultMessage];
            if(resultMessage == nil){
                resultMessage = @"未知错误!";
            }
            NSError *error =[NSError errorWithDomain:resultMessage code:codeStr.integerValue userInfo:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

+ (void)UPLOAD:(NSString *)path
    parameters:(id)parameters
   uploadParam:(SXUploadParam *)uploadParam
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure{
    
    NSString *requestPath = [NSString stringWithFormat:@"%@/%@",API_HOST,path];
    
    [SXHttpTool UPLOAD:requestPath parameters:parameters upload:uploadParam success:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:kResultCode];
        NSString *codeStr = code.description;
        if ([self validateWithStr:codeStr]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success([responseObject objectForKey:kResultContent]);
                }
            });
        }else{
            NSString *resultMessage = [responseObject objectForKey:kResultMessage];
            if(resultMessage == nil){
                resultMessage = @"未知错误!";
            }
            NSError *error =[NSError errorWithDomain:resultMessage code:codeStr.integerValue userInfo:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

+ (void)UPLOAD:(NSString *)path
    parameters:(id)parameters
        photos:(NSArray<SXUploadParam *> *)photos
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure{
    
    NSString *requestPath = [NSString stringWithFormat:@"%@/%@",API_HOST,path];
    
    [SXHttpTool UPLOAD:requestPath parameters:parameters photos:photos success:^(id responseObject) {
        
        NSNumber *code = [responseObject objectForKey:kResultCode];
        NSString *codeStr = code.description;
        if ([self validateWithStr:codeStr]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success([responseObject objectForKey:kResultContent]);
                }
            });
        }else{
            NSString *resultMessage = [responseObject objectForKey:kResultMessage];
            if(resultMessage == nil){
                resultMessage = @"未知错误!";
            }
            NSError *error =[NSError errorWithDomain:resultMessage code:codeStr.integerValue userInfo:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
}

#pragma mark -验证状态码-
+ (BOOL)validateWithStr:(NSString *)str{
    return [str isEqualToString:@"0"] || [str isEqualToString:@"1"];
}

@end
