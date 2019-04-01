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

//绑定小K通知
+ (void)postNotificationBindXiaoKiSuccess;
+ (void)addObserverBindXiaoKiSuccess:(id)observer selector:(SEL)selector;
+ (void)removeObserverBindXiaoKi:(id)observer;

//更改手机备注通知
+ (void)postNotificationDeviceUpdateRemarkSuccess;
+ (void)addObserverDeviceUpdateRemarkSuccess:(id)observer selector:(SEL)selector;
+ (void)removeObserverDeviceUpdateRemark:(id)observer;

@end

