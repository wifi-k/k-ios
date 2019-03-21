//
//  SXNotificationCenterTool.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXNotificationCenterTool : NSObject

+ (void)removeObserverAll:(id)observer;

//修改昵称通知
+ (void)postNotificationUdpateNickNameSuccess;
+ (void)addObserverUdpateNickNameSuccess:(id)observer selector:(SEL)selector;
+ (void)removeObserverUdpateNickName:(id)observer;

//修改手机号通知
+ (void)postNotificationUpdateMobileSuccess;
+ (void)addObserverUpdateMobileSuccess:(id)observer selector:(SEL)selector;
+ (void)removeObserverUpdateMobile:(id)observer;

@end

