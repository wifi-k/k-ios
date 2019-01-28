//
//  UIView+Extension.h
//  duotinfm
//
//  Created by xuan on 16/10/19.
//  Copyright © 2016年 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/** 水平居中 */
- (void)alignHorizontal;
/** 垂直居中 */
- (void)alignVertical;

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

/** 圆角图片（默认样式） */
- (void)roundViewWithRadius:(float)rd;

/** 圆角图片 */
- (void)roundViewWithRadius:(float)rd borderColor:(UIColor *)color borderWidth:(float)borderWidth;

- (void)shadowViewWithCornerRadius:(float)rd1 shadowRadius:(float)rd2 shadowOpacity:(float)opacity size:(CGSize)size;//图片阴影

@end
