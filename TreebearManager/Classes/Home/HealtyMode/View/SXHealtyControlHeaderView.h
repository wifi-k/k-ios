//
//  SXHealtyControlHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlHeaderView : UIView

+ (instancetype)headerView;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditTimeBlock)(void);

@end

NS_ASSUME_NONNULL_END
