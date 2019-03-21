//
//  SXPersonalInfoController.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPersonalInfoController : UIViewController

///修改头像回调
@property (nonatomic, copy) void (^updateAvatarImgBlock)(void);

@end

NS_ASSUME_NONNULL_END
