//
//  SXNickNameUpdateController.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMineUserInfoParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNickNameUpdateController : UIViewController

@property (nonatomic, strong) SXMineUserInfoParam *param;

///修改昵称回调
@property (nonatomic, copy) void (^updateNickNameBlock)(void);

@end

NS_ASSUME_NONNULL_END
