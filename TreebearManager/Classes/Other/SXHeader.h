//
//  SXHeader.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#ifndef SXHeader_h
#define SXHeader_h

// 通知中心
#define SXNotificationCenter [NSNotificationCenter defaultCenter]
//主窗口
#define SXKeyWindow [UIApplication sharedApplication].keyWindow
#define SXDelegateWindow UIApplication.sharedApplication.delegate.window
//weak修饰
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
//非空字符串
#define NotNull(string) (string == nil ? @"":string)
//非空对象
#define OBJ_SAFE(__obj__) (__obj__ ? __obj__ : [NSNull null])

//判断字典是否为空
#define kDictionaryIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 判断字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] <= 0 ? YES : NO )

#ifdef DEBUG
#define DLog(fmt,...) NSLog((@"%s [gLine %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//屏幕尺寸
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/** 尺寸 */
#define SCREEN_POINT (float)SCREEN_WIDTH/375.f
#define SCREEN_H_POINT (float)SCREEN_HEIGHT/1334/2.f

//设备信息
#define DEVICE_UUID UIDevice.currentDevice.identifierForVendor.UUIDString // UUID
#define DEVICE_VERSION UIDevice.currentDevice.systemVersion //系统版本号
#define DEVICE_MODEL UIDevice.currentDevice.model //设备机型

//应用信息
#define APP_VERSION [NSBundle.mainBundle objectForInfoDictionaryKey: @"CFBundleShortVersionString"]
#define APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_VERSION_CODE [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_BUNDLEID [[NSBundle mainBundle] bundleIdentifier]
#define APP_KEYCHAIN @"CloudContract"
#define ChannelId @"AppStore"

//手机版本
#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

//#define IS_IPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
/**  获取状态栏高度 原来20, iPhone X 44  */
#define kStatusHeight  MIN([UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width)

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/**
 *导航栏高度
 */
#define SafeAreaTopHeight (IPHONE_X ? 88 : 64)

/**
 *tabbar高度
 */
#define SafeAreaBottomHeight (IPHONE_X ? (49 + 34) : 49)

/** iPhone X 补高度 **/
#define iPhoneX_top ((IPHONE_X) ? 24 : 0)
#define iPhoneX_Add_Top ((IPHONE_X) ? 44 : 0) //顶部
#define iPhoneX_Add_Bottom ((IPHONE_X) ? 34 : 0) //底部

//第三方key
#define UMengAppKey @"5c9c2fc23fc195c4c100020b" // UMeng
#define UMSocialKey @"5c9c2fc23fc195c4c100020b" // UMeng Share
#define UMSocialSecret @"lpshgbh0wgxlximdeifmkfcrhzhtnqfz" // UMeng Secret
#define WeChatAppID     @"wx5056e8618341b094"   // WeChat
#define WeChatAppSecret @"31da4f1ee530ab9ddf8fe26102afc197"

#define RedirectURL @"https://www.treebear.cn"

#endif /* SXHeader_h */
