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
    
+ (void)change;

@end

NS_ASSUME_NONNULL_END
