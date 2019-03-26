//
//  SXFamilyMemberModel.m
//  TreebearManager
//
//  Created by bear on 2019/3/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberModel.h"

@implementation SXFamilyMemberModel

- (BOOL)isEqual:(SXFamilyMemberModel *)other{
    return [self.userId isEqual:other.userId];
}

@end
