//
//  SXPhotoBrowserCustomButton.m
//  TreebearManager
//
//  Created by bear on 2019/4/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserCustomButton.h"

@implementation SXPhotoBrowserCustomButton

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
//    self.titleLabel.contentMode = NSTextAlignmentCenter;
//    self.titleLabel.font = SXFont10;
//    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = SXFont10;
    self.imageView.contentMode = UIViewContentModeCenter;
}

#pragma mark - 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
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