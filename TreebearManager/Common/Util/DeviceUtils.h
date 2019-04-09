//
//  DeviceUtils.h
//  TreebearManager
//
//  Created by bear on 2019/4/9.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtils : NSObject

//DeviceUtils.h中定义
#pragma mark - About Device Config Info Method
/**
 *  获取当前设备的IMSI值
 */
+ (NSString *)getDeviceIMSIValue;

/**
 *  获取当前设备的IMEI值
 */
+ (NSString *)getDeviceIMEIValue;

/**
 *  获取当前设备的MacId值
 */
+ (NSString *)getDeviceMacIdValue;

@end

NS_ASSUME_NONNULL_END
