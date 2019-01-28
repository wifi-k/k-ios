//
//  SXUtil.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUtil.h"
#import <SAMKeychain.h>

@implementation SXUtil

//获取设备id
+ (NSString *)deviceId{
    NSString *currentDeviceUUIDStr = [SAMKeychain passwordForService:APP_KEYCHAIN account:APP_KEYCHAIN];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""]){
        NSUUID *currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword: currentDeviceUUIDStr forService:APP_KEYCHAIN account:APP_KEYCHAIN];
    }
    return currentDeviceUUIDStr;
}

@end
