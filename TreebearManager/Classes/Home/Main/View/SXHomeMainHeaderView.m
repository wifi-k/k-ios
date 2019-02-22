//
//  SXHomeMainHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainHeaderView.h"

@interface SXHomeMainHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@end

@implementation SXHomeMainHeaderView

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
    
- (void)setUpUI{
    
    self.backgroundColor = SXColorRandom;
    
    self.topBgView.backgroundColor = [UIColor whiteColor];
    self.topBgView.layer.cornerRadius = 6;
    self.topBgView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.topBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.topBgView.layer.shadowOpacity = 0.5;
    self.topBgView.layer.shadowRadius = 5;
}

@end
