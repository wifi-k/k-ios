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

@implementation SXLoginNetTool

+ (void)getCodeDataWithMobile:(NSString *)mobile Success:(void (^)(void))success failure:(void (^)(NSError *error))failure{
    
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    [SXNetRequestTool POST:@"user/vcode/get" parameters:param.mj_keyValues success:^(id response) {
        
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
