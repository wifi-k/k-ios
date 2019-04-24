//
//  SXForbiddenDeviceOptionController.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTablePlainRrfreshController.h"
#import "SXTimeControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenDeviceOptionController : SXBaseCustomTablePlainRrfreshController

///时间控制模型
@property (nonatomic, strong) SXTimeControlModel *model;

///点击回调
@property (nonatomic, copy) void (^selectForbiddenOptionBlock)(NSArray *selectedList);

@end

NS_ASSUME_NONNULL_END
