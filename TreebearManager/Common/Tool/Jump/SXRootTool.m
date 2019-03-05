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
    
+ (UIViewController *)rootViewController{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return rootVC;
}
    
    
+ (void)changeToMainHomeVC{
    UIViewController *rootVC = self.rootViewController;
    if ([rootVC isKindOfClass:[SXTabBarController class]]) {
        SXTabBarController *tabBarVC = (SXTabBarController *)rootVC;
        [tabBarVC changeToMainHomeVC];
    }
}
    
+ (void)changeToHomeVC{
    UIViewController *rootVC = self.rootViewController;
    if ([rootVC isKindOfClass:[SXTabBarController class]]) {
        SXTabBarController *tabBarVC = (SXTabBarController *)rootVC;
        [tabBarVC changeToHomeVC];
    }
}

+ (void)changeToPhotoVC{
    UIViewController *rootVC = self.rootViewController;
    if ([rootVC isKindOfClass:[SXTabBarController class]]) {
        SXTabBarController *tabBarVC = (SXTabBarController *)rootVC;
        tabBarVC.selectedIndex = 1;
    }
}

+ (void)jumpToVC:(UIViewController *)controller{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if([rootVC isKindOfClass:[SXNavigationController class]]) {
        SXNavigationController *naviVC = (SXNavigationController *)rootVC;
        [naviVC pushViewController:controller animated:YES];
    }
}

+ (void)jumpToSystemWIFI{
    NSURL *url = [NSURL URLWithString:@"App-Prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    } else {
        NSURL *url2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url2]) {
            [[UIApplication sharedApplication] openURL:url2];
        }
    }
}

+ (void)jumpToSystemAppSetting{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
    
@end
