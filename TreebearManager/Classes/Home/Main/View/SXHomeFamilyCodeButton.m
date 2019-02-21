//
//  SXHomeFamilyCodeButton.m
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeFamilyCodeButton.h"

@implementation SXHomeFamilyCodeButton

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
    
    [self setTitle:@"输入家庭码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self setTitleColor:SXColor999999 forState:UIControlStateHighlighted];
    [self setTitleColor:SXColor666666 forState:UIControlStateNormal];
    [self setTitleColor:SXColor666666 forState:UIControlStateDisabled];
    
    [self roundViewWithRadius:15.0f borderColor:SXColor666666 borderWidth:1.5f];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        [self borderColor:SXColor999999 borderWidth:1.5f];
    } else{
        [self borderColor:SXColor666666 borderWidth:1.5f];
    }
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
