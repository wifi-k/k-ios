//
//  SXBaseParam.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"
#import "SXUtil.h"

@implementation SXBaseParam

+ (instancetype)param{
    SXBaseParam *param = [[self alloc] init];
    param.device_id = SXUtil.deviceId;
    return param;
}

@end
