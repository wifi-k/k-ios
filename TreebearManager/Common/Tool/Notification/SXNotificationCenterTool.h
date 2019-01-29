//
//  SXNotificationCenterTool.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXNotificationCenterTool : NSObject

//发送完成，通知刷新
+ (void)postSignSucccessNotice;
+ (void)observerNoticeSignSucccess:(id)observer selector:(SEL)selector;
+ (void)removeObserver:(id)observer;
    
@end

