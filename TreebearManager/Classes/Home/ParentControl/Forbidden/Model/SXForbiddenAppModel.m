//
//  SXForbiddenAppModel.m
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppModel.h"

@implementation SXForbiddenAppModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"modelId":@"id"};
}

- (BOOL)isEqual:(SXForbiddenAppModel *)other{
    return [self.modelId isEqual:other.modelId];
}

@end
