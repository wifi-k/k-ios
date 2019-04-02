//
//  SXTimeUpdateController.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTimeControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeUpdateController : UIViewController

///时间控制模型
@property (nonatomic, strong) SXTimeControlModel *model;
///点击确定按钮回调
@property (nonatomic, copy) void (^selectTimeControlOptionBlock)(SXTimeControlModel *model);

@end

NS_ASSUME_NONNULL_END
