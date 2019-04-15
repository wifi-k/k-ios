//
//  SXForbiddenAppHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/4/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppHeaderView.h"


@interface SXForbiddenAppHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SXForbiddenAppHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.titleL.textColor = SXColor7383A2;
}

@end
