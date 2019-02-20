//
//  SXTitleImageButton.m
//  TreebearManager
//
//  Created by bear on 2019/2/20.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTitleImageButton.h"

@implementation SXTitleImageButton

- (void)awakeFromNib{
    [super awakeFromNib];
    //通过xib加载的时候调用
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGFloat titleW = 0;
    //判断运行时
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        //判断编译时
#ifdef __IPHONE_7_0
        titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.width;
#else
        titleW = [self.currentTitle sizeWithFont:[UIFont systemFontOfSize:15]].width;
#endif
    } else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        titleW = [self.currentTitle sizeWithFont:[UIFont systemFontOfSize:15]].width;
#pragma clang diagnostic pop
    }
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 15;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
