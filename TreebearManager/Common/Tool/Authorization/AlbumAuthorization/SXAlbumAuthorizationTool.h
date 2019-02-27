//
//  SXAlbumAuthorizationTool.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXAlbumAuthorizationTool : NSObject

///检查是否有相册权限
+ (void)checkAlbumAuthorization:(void (^)(NSInteger status))block;

///获取相册权限
+ (void)requestAlbumAuthorizationSuccess:(void (^)(void))success failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
