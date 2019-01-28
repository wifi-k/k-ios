//
//  SXRootTool.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRootTool.h"
#import "SXTabBarController.h"
#import "SXNavigationController.h"
#import "SXLoginMainController.h"

@implementation SXRootTool

+ (void)chooseRootWithTabBarVC:(UIWindow *)window{
    SXTabBarController *tabBarVC = [[SXTabBarController alloc] init];
    window.rootViewController = tabBarVC;
}

+ (void)chooseRootWithLoginVC:(UIWindow *)window{
    SXLoginMainController *loginVC = [[SXLoginMainController alloc] init];
    SXNavigationController *naviVC = [[SXNavigationController alloc] initWithRootViewController:loginVC];
    window.rootViewController = naviVC;
}

+ (UIViewController *)topViewController{
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC;
    if ([rootVC isKindOfClass:[SXTabBarController class]]) {
        SXTabBarController *tabVC = (SXTabBarController *)rootVC;
        SXNavigationController *naviVC = (SXNavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
        topVC = naviVC.topViewController;
    }else if([rootVC isKindOfClass:[SXNavigationController class]]) {
        SXNavigationController *naviVC = (SXNavigationController *)rootVC;
        topVC = naviVC.topViewController;
    }else{
        topVC = rootVC;
    }
    return topVC;
}

@end
