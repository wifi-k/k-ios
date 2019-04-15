//
//  SXOnlineOptionButton.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineOptionButton.h"

@implementation SXOnlineOptionButton

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
    
    [self setBackgroundColor:UIColor.whiteColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self setTitle:@"自动获取IP地址" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [self setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
}

#pragma mark - 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageX = contentRect.size.width - 30;
    CGFloat imageY = 0;
    CGFloat imageW = 30 - 10;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

#pragma mark - 调整内部UIlable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - 30;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
