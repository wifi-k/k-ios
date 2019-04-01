//
//  SXNotificationCenterTool.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNotificationCenterTool.h"

NSString *const SXUpdateNickName = @"SXUpdateNickName";
NSString *const SXUpdateMobile = @"SXUpdateMobile";
NSString *const SXBindXiaoKi = @"SXBindXiaoKi";
NSString *const SXDeviceUpdateRemark = @"SXDeviceUpdateRemark";

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
    
+ (void)removeObserverUdpateNickName:(id)observer{
    [SXNotificationCenter removeObserver:observer name:SXUpdateNickName object:nil];
}

+ (void)postNotificationUpdateMobileSuccess{
    [SXNotificationCenter postNotificationName:SXUpdateMobile object:self userInfo:nil];
}

+ (void)addObserverUpdateMobileSuccess:(id)observer selector:(SEL)selector{
    [SXNotificationCenter addObserver:observer selector:selector name:SXUpdateMobile object:nil];
}

+ (void)removeObserverUpdateMobile:(id)observer{
    [SXNotificationCenter removeObserver:observer name:SXUpdateMobile object:nil];
}

+ (void)postNotificationBindXiaoKiSuccess{
    [SXNotificationCenter postNotificationName:SXBindXiaoKi object:self userInfo:nil];
}
+ (void)addObserverBindXiaoKiSuccess:(id)observer selector:(SEL)selector{
    [SXNotificationCenter addObserver:observer selector:selector name:SXBindXiaoKi object:nil];
}
+ (void)removeObserverBindXiaoKi:(id)observer{
    [SXNotificationCenter removeObserver:observer name:SXBindXiaoKi object:nil];
}

+ (void)postNotificationDeviceUpdateRemarkSuccess{
    [SXNotificationCenter postNotificationName:SXDeviceUpdateRemark object:self userInfo:nil];
}
+ (void)addObserverDeviceUpdateRemarkSuccess:(id)observer selector:(SEL)selector{
    [SXNotificationCenter addObserver:observer selector:selector name:SXDeviceUpdateRemark object:nil];
}
+ (void)removeObserverDeviceUpdateRemark:(id)observer{
    [SXNotificationCenter removeObserver:observer name:SXDeviceUpdateRemark object:nil];
}
    
@end
