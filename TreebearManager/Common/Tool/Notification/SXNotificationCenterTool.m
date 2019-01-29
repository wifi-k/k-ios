//
//  SXNotificationCenterTool.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNotificationCenterTool.h"

@implementation SXNotificationCenterTool

+ (void)postSignSucccessNotice{
    [SXNotificationCenter postNotificationName:@"signSucccessNotice" object:self userInfo:nil];
}
    
+ (void)observerNoticeSignSucccess:(id)observer selector:(SEL)selector{
    [SXNotificationCenter addObserver:observer selector:selector name:@"signSucccessNotice" object:nil];
}
    
+ (void)removeObserver:(id)observer{
    [SXNotificationCenter removeObserver:observer name:@"signSucccessNotice" object:nil];
}
    
@end
