//
//  SXDynamicHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXDynamicParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXDynamicHeaderView : UIView

+ (instancetype)headerView;

///动态上网参数
@property (nonatomic, strong) SXDynamicParam *param;

///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
