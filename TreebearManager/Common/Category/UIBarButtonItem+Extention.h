//
//  UIBarButtonItem+Extention.h
//  read_gzh
//
//  Created by xuan on 2017/4/23.
//  Copyright © 2017年 duotin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extention)

//返回Item中的Button按钮
- (UIButton *)customButton;

//传入自定义按钮
+ (UIBarButtonItem *)barButtonItemWithCustomButton:(UIButton *)btn;

//只含图片按钮
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

//只含文字按钮
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

//图片文字按钮（工具条上下样式）
+ (UIBarButtonItem *)toolBarButtonItemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
