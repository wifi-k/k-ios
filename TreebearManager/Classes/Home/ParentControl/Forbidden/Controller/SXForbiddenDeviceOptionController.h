//
//  SXForbiddenDeviceOptionController.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTablePlainRrfreshController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenDeviceOptionController : SXBaseCustomTablePlainRrfreshController

///点击回调
@property (nonatomic, copy) void (^selectForbiddenOptionBlock)(NSString *model);

@end

NS_ASSUME_NONNULL_END
