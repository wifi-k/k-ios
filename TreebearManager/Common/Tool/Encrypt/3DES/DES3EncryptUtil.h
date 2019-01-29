//
//  DES3EncryptUtil.h
//  CQMQDB
//
//  Created by xuan on 2017/8/16.
//  Copyright © 2017年 xuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3EncryptUtil : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText secretKey:(NSString *)secretKey;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText secretKey:(NSString *)secretKey;

@end
