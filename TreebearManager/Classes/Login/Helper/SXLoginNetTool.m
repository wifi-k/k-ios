//
//  SXLoginNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginNetTool.h"
#import "SXNetRequestTool.h"
#import "SXLoginParam.h"
#import <YYKit/NSObject+YYModel.h>

@implementation SXLoginNetTool

+ (void)getCodeDataWithMobile:(NSString *)mobile Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.type = @4;
    
    NSString *mj_JSONString = param.mj_JSONString;
    DLog(@"mj_JSONString:%@",mj_JSONString);
    
    NSString *modelStr = [param modelToJSONString];
    
    NSData *jsonData = [modelStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    DLog(@"dic:%@",dic);
//    NSDictionary *dfdfdfd = @{@"type":@4,@"mobile":@"13262271065",@"token":@"shenma"};
    
    NSDictionary *dfdfdfd = @{@"mobile":@"13262271065",@"type":@4};
    
//    param.device_id = SXUtil.deviceId;
    //    param.version = @(100);
    DLog(@"dfdfdfd:%@",dfdfdfd);
    
    [SXNetRequestTool POST:@"user/vcode/getv2" parameters:dfdfdfd success:^(id response) {
        
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
