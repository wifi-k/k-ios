//
//  SXNotificationCenterTool.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNotificationCenterTool.h"

NSString *const SXUpdateNickName = @"SXUpdateNickName";

@implementation SXNotificationCenterTool

+ (void)removeObserverAll:(id)observer{
    [SXNotificationCenter removeObserver:observer];
}

//----//----//----//----//----//----
//----//----//----//----//----//----


+ (void)postNotificationUdpateNickNameSuccess{
    [SXNotificationCenter postNotificationName:SXUpdateNickName object:self userInfo:nil];
}
    
+ (void)addObserverUdpateNickNameSuccess:(id)observer selector:(SEL)selector{
    [SXNotificationCenter addObserver:observer selector:selector name:SXUpdateNickName object:nil];
}
    
+ (void)removeObserver:(id)observer{
    [SXNotificationCenter removeObserver:observer name:SXUpdateNickName object:nil];
}
    
@end
