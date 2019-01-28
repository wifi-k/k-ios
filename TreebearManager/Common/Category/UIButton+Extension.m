//
//  UIButton+Extension.m
//  CQMQDB
//
//  Created by xuan on 2017/9/4.
//  Copyright © 2017年 xuan. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(3, 3), NO, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 3, 3)];
    [backgroundColor setFill];
    [path fill];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    [self setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forState:state];
}

@end
