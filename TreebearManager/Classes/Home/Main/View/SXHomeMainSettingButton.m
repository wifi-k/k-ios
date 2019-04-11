//
//  SXHomeMainSettingButton.m
//  TreebearManager
//
//  Created by bear on 2019/2/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSettingButton.h"

@implementation SXHomeMainSettingButton

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUpUI];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    [self setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateHighlighted];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = SXFontBold12;
    self.imageView.contentMode = UIViewContentModeCenter;
}

#pragma mark - 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageX = 0;
    CGFloat imageY = 5;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height - 20;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

#pragma mark - 调整内部UIlable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height - 20 - 10;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
