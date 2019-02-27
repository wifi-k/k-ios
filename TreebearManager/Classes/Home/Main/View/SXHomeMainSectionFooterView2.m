//
//  SXHomeMainSectionFooterView2.m
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionFooterView2.h"

@interface SXHomeMainSectionFooterView2 ()

@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UIView *reportBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXHomeMainSectionFooterView2

+ (instancetype)footerView{
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
    
    self.backgroundColor = SXColorWhite;
    
    self.topBgView.backgroundColor = SXColorWhite;
    
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    [self.reportBtn roundViewWithRadius:15.0f];
}

@end
