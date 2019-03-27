//
//  SXXiaoKInfoModel.m
//  TreebearManager
//
//  Created by bear on 2019/3/20.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKInfoModel.h"

@implementation SXXiaoKInfoModel

SingletonImplementation(SXXiaoKInfoModel)

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id"};
}

- (instancetype)setDataWithResult:(SXXiaoKNodeResult *)result{
    self.modelId = result.modelId;
    self.ip = result.wan.ip;
    self.netmask = result.wan.netmask;
    self.gateway = result.wan.gateway;
    self.dns1 = result.wan.dns1;
    self.dns2 = result.wan.dns2;
    self.type = result.wan.type;
    self.name = result.wan.name;
    self.passwd = result.wan.passwd;
    return self;
}

@end
