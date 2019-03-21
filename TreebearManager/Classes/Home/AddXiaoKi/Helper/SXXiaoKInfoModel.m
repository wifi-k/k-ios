//
//  SXXiaoKInfoModel.m
//  TreebearManager
//
//  Created by bear on 2019/3/20.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKInfoModel.h"

@implementation SXXiaoKInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id"};
}

SingletonImplementation(SXXiaoKInfoModel)

@end
