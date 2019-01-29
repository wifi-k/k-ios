//
//  SXUserDefaultsTool.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUserDefaultsTool.h"

///App版本号
static NSString * const kVersionKey = @"kVersionKey";

@implementation SXUserDefaultsTool

+ (void)saveAppVersion:(NSString *)currentVersion{
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
    
+ (NSString *)version{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
}
    
@end
