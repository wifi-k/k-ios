//
//  SXTimeControlEditController.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeControlEditController : UIViewController

///点击选择时间回调
@property (nonatomic, copy) void (^selectTimeBlock)(void);

@end

NS_ASSUME_NONNULL_END
