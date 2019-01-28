//
//  SXBaseParam.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseParam : NSObject

///设备的token
@property (nonatomic, copy) NSString *device_token;
///当前本地版本号
@property (nonatomic, copy) NSNumber *version;
///设备Id
@property (nonatomic, copy) NSString *device_id;

+ (instancetype)param;

@end

NS_ASSUME_NONNULL_END
