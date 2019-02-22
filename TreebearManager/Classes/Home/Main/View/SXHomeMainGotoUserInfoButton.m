//
//  SXHomeMainGotoUserInfoButton.m
//  TreebearManager
//
//  Created by bear on 2019/2/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainGotoUserInfoButton.h"

@implementation SXHomeMainGotoUserInfoButton

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
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self setTitle:@"我的小K" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self setTitleColor:SXColorWhite forState:UIControlStateNormal];
    //[self setTitleColor:SXColor666666 forState:UIControlStateHighlighted];
}

//- (void)setHighlighted:(BOOL)highlighted{
//    [super setHighlighted:highlighted];
//
//    if (highlighted) {
//        [self borderColor:SXColor666666 borderWidth:1.0f];
//    } else{
//        [self borderColor:SXColor999999 borderWidth:1.0f];
//    }
//}

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
