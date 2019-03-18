//
//  SXHealtyTimeController.h
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHealtyControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyTimeController : UIViewController

///数据模型
@property (nonatomic, strong) SXHealtyControlModel *model;
///点击确定按钮回调
@property (nonatomic, copy) void (^selectTimeOptionBlock)(SXHealtyControlModel *model);

@end

NS_ASSUME_NONNULL_END
