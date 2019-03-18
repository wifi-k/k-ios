//
//  SXForbiddenAppOptionController.h
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppOptionController : UIViewController

///点击回调
@property (nonatomic, copy) void (^selectForbiddenOptionBlock)(NSString *model);

@end

NS_ASSUME_NONNULL_END
