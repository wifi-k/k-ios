//
//  SXRootTool.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXRootTool : NSObject

+ (void)chooseRootWithTabBarVC:(UIWindow *)window;

+ (void)chooseRootWithLoginVC:(UIWindow *)window;

+ (UIViewController *)topViewController;
    
+ (UIViewController *)rootViewController;

///连接成功
+ (void)changeToMainHomeVC;
///连接失败
+ (void)changeToHomeVC;

@end

NS_ASSUME_NONNULL_END
