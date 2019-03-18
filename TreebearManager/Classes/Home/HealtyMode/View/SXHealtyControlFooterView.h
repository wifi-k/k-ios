//
//  SXHealtyControlFooterView.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlFooterView : UIView

+ (instancetype)footerView;

///点击添加按钮回调
@property (nonatomic, copy) void (^clickAddTimeBlock)(void);

@end

NS_ASSUME_NONNULL_END
