//
//  NSString+Extension.m
//  CloudContract
//
//  Created by xuan on 2018/6/29.
//  Copyright © 2018年 xuan. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)isEmpty{
    return self == nil || [@"" isEqualToString:self] || [@"(null)" isEqualToString:self];
}

- (BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isContainChinese{
    for(int i=0; i< [self length];i++){
        int a =[self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isPassword
{
    NSString *regex = @"(^[A-Za-z0-9]{6,20}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isUrl
{
    NSString *regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isPhoneNumber
{
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1[3578]\\d{9}$"];
    // JavaScript的正则表达式:\^1[3578]\\d{9}$\
    
}

- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}

- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isLetter{
    if (self.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isNumber{
    if (self.length == 0) return NO;
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)isNumberOrLetter{
    if (self.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (instancetype)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (instancetype)filterSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)equalsIgnoreCase:(NSString *)str{
    NSString *one = [self lowercaseString];
    NSString *two = [str lowercaseString];
    return [one isEqualToString:two];
}

- (CGFloat)widthForFont:(UIFont *)font{
    CGFloat textW = 0;
    //判断运行时
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        //判断编译时
#ifdef __IPHONE_7_0
        NSDictionary *dict = @{NSFontAttributeName:font};
        textW = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.width;
#else
        textW = [self sizeWithFont:font].width;
#endif
    } else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textW = [self sizeWithFont:font].width;
#pragma clang diagnostic pop
    }
    return textW;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode{
    CGSize result;
    //设置默认大小14
    if (!font) font = [UIFont systemFontOfSize:14];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

+ (BOOL)isEmpty:(NSString *)str{
    return ![NSString isNotEmpty:str];
}

+ (BOOL)isNotEmpty:(NSString *)str{
    if (str == nil || [str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if([@"" isEqualToString:[str trim]]){
        return NO;
    }
    
    if([@"null" equalsIgnoreCase:[str trim]]){
        return NO;
    }
    
    if([@"<null>" equalsIgnoreCase:[str trim]]){
        return NO;
    }
    
    if([@"undefined" equalsIgnoreCase:[str trim]]){
        return NO;
    }
    
    return YES;
}

+ (instancetype)stringWithCityName:(NSString *)cityNameStr{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:cityNameStr];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    //转化为大写拼音
    return pinYin;
}

+ (instancetype)stringWithTimestamp:(NSNumber *)timestamp{
    
    //长度转变NSDate
    CGFloat timeF = (timestamp.floatValue + 8 * 60 * 60 * 1000)/1000;
    NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:timeF];
    //格式化
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    fm.dateFormat = @"MM-dd HH:mm";
    [fm setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zh"]];
    //转成字符串
    return [fm stringFromDate:timestampDate];
}

+ (instancetype)stringWithTimestamp2:(NSString *)timestamp{
    //如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //long long time = [timeStr longLongValue] / 1000;
    long long time = [timestamp longLongValue];
    NSDate *timestampDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zh"]];
    NSString *timeString = [formatter stringFromDate:timestampDate];
    return timeString;
}

- (instancetype)currentVersion{
    if ([NSString isEmpty:self]) {
        return 0;
    }
    NSArray *versionArr = [self componentsSeparatedByString:@"."];
    double version = 0;
    for (int i=0; i<versionArr.count; i++) {
        version += [versionArr[i] integerValue] * pow(10,versionArr.count-1-i);
    }
    return [NSString stringWithFormat:@"%0.f",version];
}

+ (NSString *)getBinaryByDecimal:(NSInteger)decimal{
    NSString *binary = @"";
    while (decimal) {
        binary = [[NSString stringWithFormat:@"%ld", decimal % 2] stringByAppendingString:binary];
        if (decimal / 2 < 1) {
            break;
        }
        decimal = decimal / 2 ;
    }
    if (binary.length % 4 != 0) {
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    return binary;
}

+ (NSString *)convertBinarySystemFromDecimalSystem:(NSString *)decimal{
    NSInteger num = [decimal intValue];
    NSInteger remainder = 0;      //余数
    NSInteger divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true){
        
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%ld",remainder];
        
        if (divisor == 0){
            
            break;
        }
    }
    
    NSString * result = @"";
    
    for (NSInteger i = prepare.length - 1; i >= 0; i --){
        
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}

@end
