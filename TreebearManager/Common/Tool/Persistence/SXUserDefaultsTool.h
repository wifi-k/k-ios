//
//  SXUserDefaultsTool.h
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXUserDefaultsTool : NSObject

///保存版本号到本地
+ (void)saveAppVersion:(NSString *)currentVersion;
    
///取出版本号
+ (NSString *)version;

///保存引导记录
+ (void)saveShowGuide:(BOOL)isShowGuide;

///取出记录
+ (BOOL)isShowGuide;
    
@end
