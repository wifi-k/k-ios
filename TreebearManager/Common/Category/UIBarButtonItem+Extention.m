//
//  UIBarButtonItem+Extention.m
//  read_gzh
//
//  Created by xuan on 2017/4/23.
//  Copyright © 2017年 duotin. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"
#import "UIButton+EnlargeArea.h"

@implementation UIBarButtonItem (Extention)

- (UIButton *)customButton{
    return self.customView;
}

+ (UIBarButtonItem *)barButtonItemWithCustomButton:(UIButton *)btn{
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    btn.contentMode = UIViewContentModeCenter;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setEnlargeEdgeWithTop:10.0 right:10.0 bottom:10.0 left:10.0];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)toolBarButtonItemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    //btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn setEnlargeEdgeWithTop:10.0 right:10.0 bottom:10.0 left:10.0];
    if (title){
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.cyanColor forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, -28, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -20);
    }
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
