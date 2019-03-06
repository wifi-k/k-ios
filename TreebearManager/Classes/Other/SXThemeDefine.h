//
//  SXThemeDefine.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#ifndef SXThemeDefine_h
#define SXThemeDefine_h

#import "UIColor+BFKit.h"

#pragma mark -主题颜色-

// RGB颜色
#define SXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define SXColorRandom SXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// RGBA
#define SXColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// RGB 1
#define SXColorRGB(r,g,b) SXColorRGBA(r,g,b,1)

// S 1
#define SXColorSingleA(s,a) SXColorRGBA(s,s,s,a)
#define SXColorSingle(s) SXColorSingleA(s,1)

// S 0.8
#define SXColorSVProgressBgColor SXColorSingleA(255,0.8)

//自定义颜色
#define SXColorCSS(S)  [UIColor hex:@S]

//主题黑 -> 灰(由深到浅)
#define SXColorGray1  [UIColor hex:@"333333"]
#define SXColorGray2  [UIColor hex:@"666666"]
#define SXColorGray3  [UIColor hex:@"7A7A7A"]
#define SXColorGray4  [UIColor hex:@"A3A3A3"]
#define SXColorGray5  [UIColor hex:@"CCCCCC"]
#define SXColorGray6  [UIColor hex:@"D8D8D8"]
#define SXColorGray7  [UIColor hex:@"F0F0F0"]
#define SXColorGray8  [UIColor hex:@"FFFFFF"]

//文本灰色
#define SXColorB2B2B2  [UIColor hex:@"B2B2B2"]
#define SXColor2F2F2F  [UIColor hex:@"2F2F2F"]
#define SXColorC5C5C5  UIColorFromRGB(0xC5C5C5) // 浅灰

//按钮状态颜色
#define SXColorBtnNormal [UIColor hex:@"F5F5F5"]
#define SXColorBtnDisabled [UIColor hex:@"D5D5D5"]
#define SXColorBtnHighlight [UIColor hex:@"D8D8D8"]

//导航两边字体颜色
#define SXColorNavigationItemText [UIColor hex:@"141414"]

//灰色视图背景颜色
#define SXColorBgViewGray [UIColor hex:@"f5f5f5"]
//视图间隔线颜色
#define SXColorDivideLine [UIColor hex:@"dde1f1"]

/** 颜色相关 */
#define SC_RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)] // RGB
/** 随机颜色 */
#define SC_RandomlyColor SC_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)
/** 颜色转换 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SXColorClear UIColor.clearColor       // 透明色
#define SXColorCCCCC UIColorFromRGB(0xCCCCCC) // 深灰色
#define SXColorWhite UIColorFromRGB(0xffffff) // 白色
#define SXColorBlue UIColorFromRGB(0x1AD0CE) // 主题蓝色
#define SXColorBlue2 UIColorFromRGB(0x26DCBC) // 中等蓝色
#define SXColorBlueLight UIColorFromRGB(0x37EDA3) // 浅蓝色(辅色)
#define SXColor333333 UIColorFromRGB(0x333333) // 用于标题 重要文字等_黑色
#define SXColor666666 UIColorFromRGB(0x666666) // 用于小标题 正文等_半度灰
#define SXColor999999 UIColorFromRGB(0x999999) // 半度灰
#define SXColor3B3B3B UIColorFromRGB(0x3B3B3B) // 重灰
#define SXColor6B6B6B UIColorFromRGB(0x6B6B6B) // 浅灰
#define SXColorF6F7FB UIColorFromRGB(0xF6F7FB) // 浅浅灰
#define SXColorOrange UIColorFromRGB(0xff9900) // 辅色(橙色)
#define SXColorPlaceholder UIColorFromRGB(0xc9c9cf) // 用于表单 输入框等提示文字
#define SXColorRed   UIColorFromRGB(0xe64340) // 红色

#pragma mark -字体大小-
//文本字体大小
#define SXFont(fontValue) [UIFont systemFontOfSize:fontValue]
#define SXFontBold(fontValue) [UIFont boldSystemFontOfSize:fontValue]
//导航中间标题文字
#define SXFontNavCenterTitle SXFont(18)
//导航item文字大小
#define SXFontNavItemTitle SXFont(15)
//字体大小（带字号）
#define SXFont21 SXFont(21)
#define SXFont20 SXFont(20)
#define SXFont19 SXFont(19)
#define SXFont18 SXFont(18)
#define SXFont17 SXFont(17)
#define SXFont16 SXFont(16)
#define SXFont15 SXFont(15)
#define SXFont14 SXFont(14)
#define SXFont13 SXFont(13)
#define SXFont12 SXFont(12)
#define SXFont11 SXFont(11)
#define SXFont10 SXFont(10)
//加粗
#define SXFontBold10 SXFontBold(10)
#define SXFontBold11 SXFontBold(11)
#define SXFontBold12 SXFontBold(12)
#define SXFontBold13 SXFontBold(13)
#define SXFontBold14 SXFontBold(14)
#define SXFontBold15 SXFontBold(15)
#define SXFontBold16 SXFontBold(16)
#define SXFontBold17 SXFontBold(17)
#define SXFontBold18 SXFontBold(18)
#define SXFontBold18 SXFontBold(18)
#define SXFontBold19 SXFontBold(19)
#define SXFontBold20 SXFontBold(20)
#define SXFontBold21 SXFontBold(21)
#define SXFontBold22 SXFontBold(22)
#define SXFontBold23 SXFontBold(23)
#define SXFontBold24 SXFontBold(24)
#define SXFontBold25 SXFontBold(25)

#endif /* SXThemeDefine_h */
