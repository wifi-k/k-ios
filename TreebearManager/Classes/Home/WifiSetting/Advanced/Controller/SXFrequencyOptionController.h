//
//  SXFrequencyOptionController.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTableViewPlainController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXFrequencyOptionController : SXBaseCustomTableViewPlainController

///选中高级设置回调
@property (nonatomic, copy) void (^selectOptionBlock)(NSString *option);

@end

NS_ASSUME_NONNULL_END
