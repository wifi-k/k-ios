//
//  XKGetWifiNetTool.m
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "XKGetWifiNetTool.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation XKGetWifiNetTool


+ (NSString *)getWifiSSID{
    //wifi名称
    NSString *strWifiName = @"未知WiFi";
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if(wifiInterfaces){
        NSArray *arrInterface = (__bridge NSArray *)wifiInterfaces;
        for (NSString *interfaceName in arrInterface) {
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if(dictRef){
                NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
                strWifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
                CFRelease(dictRef);
            }
        }
        CFRelease(wifiInterfaces);
    }
    return strWifiName;
}

+ (NSString *)getWifiBSSID{
    //wifi名称
    NSString *strWifiName = @"未知WiFi";
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if(wifiInterfaces){
        NSArray *arrInterface = (__bridge NSArray *)wifiInterfaces;
        for (NSString *interfaceName in arrInterface) {
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if(dictRef){
                NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
                strWifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
                CFRelease(dictRef);
            }
        }
        CFRelease(wifiInterfaces);
    }
    return strWifiName;
}

+ (NSString *)getWifiSSIDDATA{
    //wifi名称
    NSString *strWifiName = @"未知WiFi";
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if(wifiInterfaces){
        NSArray *arrInterface = (__bridge NSArray *)wifiInterfaces;
        for (NSString *interfaceName in arrInterface) {
            CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
            if(dictRef){
                NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
                strWifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSIDData];
                CFRelease(dictRef);
            }
        }
        CFRelease(wifiInterfaces);
    }
    return strWifiName;
}

+ (NSString *)getIPAddress{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

//获取手机当前连接WiFi信息
/*
 - (NSString *)getWifiName{
 NSString *wifiName = nil;
 CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
 if(!wifiInterfaces) {
 return @"未知";
 }
 NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
 for (NSString *interfaceName in interfaces) {
 CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
 if (dictRef){
 NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
 wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
 CFRelease(dictRef);
 }
 }
 CFRelease(wifiInterfaces);
 return wifiName;
 }
 */

@end
