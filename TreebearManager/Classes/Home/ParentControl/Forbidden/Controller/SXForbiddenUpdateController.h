//
//  SXForbiddenAppUpdateController.h
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXForbiddenAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenUpdateController : UIViewController

///禁用方案模型
@property (nonatomic, strong) SXForbiddenAppModel *model;
///点击确定按钮回调
@property (nonatomic, copy) void (^selectForbiddenOptionBlock)(SXForbiddenAppModel *model);

@end

NS_ASSUME_NONNULL_END
