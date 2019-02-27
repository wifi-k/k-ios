//
//  SXAlbumAuthorizationTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAlbumAuthorizationTool.h"
#import <Photos/Photos.h>

@implementation SXAlbumAuthorizationTool

+ (void)checkAlbumAuthorization:(void (^)(NSInteger status))block{
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    switch (photoAuthorStatus) {
        case PHAuthorizationStatusNotDetermined:// 表明用户尚未选择关于客户端是否可以访问硬件
            DLog(@"not Determined");
            block(PHAuthorizationStatusNotDetermined);
            break;
        case PHAuthorizationStatusRestricted:// 客户端未被授权访问硬件的媒体类型。用户不能改变客户机的状态,可能由于活跃的限制,如家长控制
            DLog(@"Restricted");
            block(PHAuthorizationStatusRestricted);
            break;
        case PHAuthorizationStatusDenied:// 明确拒绝用户访问硬件支持的媒体类型的客户
            DLog(@"Denied");
            block(PHAuthorizationStatusDenied);
            break;
        case PHAuthorizationStatusAuthorized:// 客户端授权访问硬件支持的媒体类型
            DLog(@"Authorized");
            block(PHAuthorizationStatusAuthorized);
            break;
        default:
            break;
    }
}

+ (void)requestAlbumAuthorizationSuccess:(void (^)(void))success failure:(void (^)(void))failure{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            DLog(@"Authorized");
            if (success) {
                success();
            }
        }else{
            DLog(@"Denied or Restricted");
            if (failure) {
                failure();
            }
        }
    }];
}

@end
