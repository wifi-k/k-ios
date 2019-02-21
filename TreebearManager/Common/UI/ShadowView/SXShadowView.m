//
//  SXShadowView.m
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXShadowView.h"

@implementation SXShadowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0x4b4773);
        //v.layer.masksToBounds=YES;这行去掉
        self.layer.cornerRadius = 10;
        self.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 5);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 5;
    }
    return self;
}

@end
