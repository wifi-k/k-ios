//
//  SXForgetHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXRegistParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForgetHeaderView : UIView
+ (instancetype)headerView;

///点击忘记密码按钮回调
@property (nonatomic, copy) void (^clickNextBtnBlock)(void);

@property (nonatomic, strong) SXRegistParam *param;
    
@end

NS_ASSUME_NONNULL_END
