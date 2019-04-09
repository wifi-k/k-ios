//
//  AppDelegate.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "AppDelegate.h"
#import "SXRootTool.h"
#import "SXNetReachablityTool.h"
#import "SXUserDefaultsTool.h"
#import <UMCommon/UMCommon.h>          // 公共组件是所有友盟产品的基础组件，必选
#import <UMSocialCore/UMSocialCore.h>  // 分享组件
#import <UMPush/UMessage.h>            // Push组件
#import <UserNotifications/UserNotifications.h> // Push组件必须的系统库
#import <UMErrorCatch/UMErrorCatch.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //设置背景色
    self.window.backgroundColor = [UIColor whiteColor];
    //显示窗口
    [self.window makeKeyAndVisible];
    //选择根控制器
    [SXRootTool chooseRootWithMainLoginVC:self.window];
    
    //设置友盟
    [self setUpUMWithLaunchingWithOptions:launchOptions];
    //监听网络状态
    [self reachablityStatus];
    
    return YES;
}

// 程序进入后台, 这个方法可用来回写缓存
- (void)applicationDidEnterBackground:(UIApplication *)application{
    DLog(@"applicationDidEnterBackground");
}

// 从后台进入前台,
- (void)applicationWillEnterForeground:(UIApplication *)application{
    DLog(@"applicationWillEnterForeground");
}

//失去焦点
- (void)applicationWillResignActive:(UIApplication *)application{
    DLog(@"applicationWillResignActive");
}

//接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];//停止所有的下载
    [[SDWebImageManager sharedManager].imageCache clearMemory];//删除缓存
}

#pragma mark -设置友盟-
- (void)setUpUMWithLaunchingWithOptions:(NSDictionary *)launchOptions{
    //关闭Crash收集
    [MobClick setCrashReportEnabled:YES];
    //友盟推送的初始
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure setEncryptEnabled:NO];//打开加密传输
    [UMConfigure initWithAppkey:UMSocialKey channel:nil];
    [UMErrorCatch initErrorCatch];
    /* 打开调试日志(分享) */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟AppKey(分享) */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMSocialKey];
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppID
                                       appSecret:WeChatAppSecret redirectURL:RedirectURL];
    // Push组件基本功能配置
    //初始化
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 用户选择了接收Push消息
            DLog("===granted=YES===");
        } else {
            // 用户拒绝接收Push消息
            DLog("===granted==NO==");
        }
    }];
    [self registerForRemoteNotifications];
}

- (void)registerForRemoteNotifications{
    if (@available(iOS 10.0, *)){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10 = UNAuthorizationOptionBadge | UNAuthorizationOptionAlert |UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted){
                DLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                }];
            } else {
                DLog(@"注册失败");
            }
        }];
    }
}

#pragma mark -监听网络状态-
- (void)reachablityStatus{
    WS(weakSelf);
    [SXNetReachablityTool reachablityStatus:^(SXNetworkStatus networkStatus) {
        switch (networkStatus) {
            case SXNetworkStatus3G:
                DLog(@"当前网络是蜂窝数据!");
                break;
            case SXNetworkStatusWifi:
                DLog(@"当前网络是无线WIFI!");
                break;
            default:
                DLog(@"当前网络状态未知!");
                break;
        }
    } fail:^(SXNetworkStatus networkStatus) {
        [MBProgressHUD showWarningWithMessage:@"当前网络不可用，请检查您的手机数据/Wifi是否开启！" toView:weakSelf.window];
    }];
}

#pragma mark -设置系统回调,支持所有iOS系统-
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    // 其他app回到自己app的时候回调的方法
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result){
        // 其他如支付等SDK的回调
        //if ([[url absoluteString] rangeOfString:@"wsloanapp://"].location != NSNotFound)
        //{
        //}
    }
    return result;
}

#pragma mark -友盟推送-
//获取测试的token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *deviceTokenStr = [[deviceToken.description stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"deviceTokenStr:%@",deviceTokenStr);
    [SXUserDefaultsTool saveDeviceToken:deviceToken.description];
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    // 如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    DLog(@"获取令牌失败:%@",error.userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [UMessage sendClickReportForRemoteNotification:userInfo];
    if(application.applicationState == UIApplicationStateActive){//活动在前台
        
    }else{
        
    }
    DLog(@"userInfo:%@",userInfo);
    [UMessage didReceiveRemoteNotification:userInfo];
}

// 静默推送必须实现此方法
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    DLog(@"userInfo:%@",userInfo);
    // 注意：当应用处在前台的时候，是不会弹出通知的，这个时候就需要自己进行处理弹出一个通知的UI
    if (application.applicationState == UIApplicationStateActive) {
        NSString *title = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"title"];
        NSString *message = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    } else if (application.applicationState == UIApplicationStateInactive){
        //如果是在后台挂起，用户点击进入是UIApplicationStateInactive这个状态
        //......
        DLog(@"UIApplicationStateInactive");
    }
    //这个是友盟自带的前台弹出框
    [UMessage setAutoAlert:NO];
//    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        [UMessage sendClickReportForRemoteNotification:userInfo]; //发送点击次数
        completionHandler(UIBackgroundFetchResultNewData);
//    }
}

//iOS10以前接收的方法
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    //这个方法用来做action点击的统计
    [UMessage sendClickReportForRemoteNotification:userInfo];
    //下面写identifier对各个交互式的按钮进行业务处理
}

//iOS10新增：处理前台收到通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    if (@available(iOS 10.0, *)) {
        NSDictionary * userInfo = notification.request.content.userInfo;
        UNNotificationRequest *request = notification.request;
        // 收到推送的请求
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        NSNumber *badge = content.badge;  // 推送消息的角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 推送消息的声音
        NSString *subtitle = content.subtitle;  // 推送消息的副标题
        NSString *title = content.title;  // 推送消息的标题
        
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [UMessage setAutoAlert:NO];
            //应用处于后台时的远程推送接受
            [UMessage didReceiveRemoteNotification:userInfo];
        }else {
            //应用处于后台时的本地推送接受
            DLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        }
        
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler(UNNotificationPresentationOptionSound |
                          UNNotificationPresentationOptionBadge |
                          UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
}

//iOS10新增：处理后台点击通知的代理方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    if (@available(iOS 10.0, *)) {
        NSDictionary * userInfo = response.notification.request.content.userInfo;
        UNNotificationRequest *request = response.notification.request; // 收到推送的请求
        UNNotificationContent *content = request.content; // 收到推送的消息内容
        NSNumber *badge = content.badge;  // 推送消息的角标
        NSString *body = content.body;    // 推送消息体
        UNNotificationSound *sound = content.sound;  // 推送消息的声音
        NSString *subtitle = content.subtitle;  // 推送消息的副标题
        NSString *title = content.title;  // 推送消息的标题
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于后台时的远程推送接受
            [UMessage didReceiveRemoteNotification:userInfo];
            DLog(@"iOS10 收到远程通知:%@", response);
            
            //这个方法用来做action点击的统计
            [UMessage sendClickReportForRemoteNotification:userInfo];
        }else {
            //应用处于后台时的本地推送接受
            DLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        }
        completionHandler();//系统要求执行这个方法
    } else {
        // Fallback on earlier versions
    }
}

@end
