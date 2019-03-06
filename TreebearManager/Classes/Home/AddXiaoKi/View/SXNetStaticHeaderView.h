//
//  SXNetStaticHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNetStaticParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNetStaticHeaderView : UIView

+ (instancetype)headerView;

///静态上网参数
@property (nonatomic, strong) SXNetStaticParam *param;

///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
