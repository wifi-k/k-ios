//
//  NSString+Extension.h
//  CloudContract
//
//  Created by xuan on 2018/6/29.
//  Copyright © 2018年 xuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark -正则表达式-
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isIPAddress;
- (BOOL)isPassword;
- (BOOL)isUrl;
- (BOOL)isEmail;
- (BOOL)isChinese;//判断是否全汉字
- (BOOL)isContainChinese;//判断是否含有汉字

///是否全字母
- (BOOL)isLetter;
///是否全数字
- (BOOL)isNumber;
///数字字母组合
- (BOOL)isNumberOrLetter;

///去字符两边空格
- (instancetype)trim;
///去字符中间空格
- (instancetype)filterSpace;

///计算文字宽度
- (CGFloat)widthForFont:(UIFont *)font;
///计算文字大小
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

///判断是否为空
+ (BOOL)isEmpty:(NSString *)str;
///判断是否不为空
+ (BOOL)isNotEmpty:(NSString *)str;
///城市名称转成拼音
+ (instancetype)stringWithCityName:(NSString *)cityNameStr;
///时间戳转成固定格式字符串
+ (instancetype)stringWithTimestamp:(NSNumber *)timestamp;
///时间戳转成日期格式(MM月dd日 HH:mm) 秒转成日期
+ (instancetype)stringWithTimestamp2:(NSString *)timestamp;
///时间戳转成日期格式(MM月dd日 HH:mm) 毫秒转成日期
+ (instancetype)stringWithTimestamp22:(NSString *)timestamp;
///时间戳转成日期格式(2018-12-08 10:00) 毫秒转成日期
+ (instancetype)stringWithTimestamp3:(NSString *)timestamp;

///版本号
- (instancetype)currentVersion;
/**
 十进制转换为二进制
 @param decimal 十进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByDecimal:(NSInteger)decimal;
#pragma mark 十进制转二进制
+ (NSString *)convertBinarySystemFromDecimalSystem:(NSString *)decimal;

@end
