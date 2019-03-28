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

#pragma mark -根控制器切换-
+ (void)chooseRootWithTabBarVC:(UIWindow *)window;

+ (void)chooseRootWithMainLoginVC:(UIWindow *)window;

+ (void)chooseRootWithLoginVC:(UIWindow *)window;

+ (void)chooseRootWithGuideVC:(UIWindow *)window;

+ (UIViewController *)topViewController;
    
+ (UIViewController *)rootViewController;

///连接成功
+ (void)changeToMainHomeVC;
///连接失败
+ (void)changeToHomeVC;
///选中相册
+ (void)changeToPhotoVC;

#pragma mark -页面跳转(不含参数)-
///push下一个页面
+ (void)pushToVC:(UIViewController *)controller;
///返回上一级页面
+ (void)popToPrevious;
///返回上级指定页面，根据名称
+ (void)popToVC:(NSString *)controllerName;

+ (void)jumpToSystemWIFI;

+ (void)jumpToSystemAppSetting;

@end

NS_ASSUME_NONNULL_END
