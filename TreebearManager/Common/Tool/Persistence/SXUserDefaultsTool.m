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
///是否已经展示过引导
static NSString * const kShowGuideKey = @"kShowGuideKey";

@implementation SXUserDefaultsTool

+ (void)saveAppVersion:(NSString *)currentVersion{
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
    
+ (NSString *)version{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
}

+ (void)saveShowGuide:(BOOL)isShowGuide{
    [[NSUserDefaults standardUserDefaults] setBool:isShowGuide forKey:kShowGuideKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isShowGuide{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kShowGuideKey];
}
    
@end
