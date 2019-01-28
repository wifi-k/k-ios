//
//  SXUtil.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXUtil : NSObject

//获取设备id(设备唯一标识，哪怕是删除应用都不会改变)
+ (NSString *)deviceId;

@end

NS_ASSUME_NONNULL_END
