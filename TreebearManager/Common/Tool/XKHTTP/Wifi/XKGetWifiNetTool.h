//
//  XKGetWifiNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XKGetWifiNetTool : NSObject

///获取当前连接wifi名称
+ (NSString *)getWifiSSID;

///获取当前连接wifi BSSID
+ (NSString *)getWifiBSSID;

///获取当前连接wifi SSIDDATA
+ (NSString *)getWifiSSIDDATA;

///获取WIFIIP的方法
+ (NSString *)getIPAddress;

@end

