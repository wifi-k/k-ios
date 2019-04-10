//
//  SXHomeMainReportCornerView.m
//  TreebearManager
//
//  Created by bear on 2019/4/10.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainReportCornerView.h"

@implementation SXHomeMainReportCornerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.backgroundColor = SXColorWhite;
    
    [self addSubview:view];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

@end
