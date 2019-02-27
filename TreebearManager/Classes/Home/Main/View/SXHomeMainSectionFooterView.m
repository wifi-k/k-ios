//
//  SXHomeMainSectionFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionFooterView.h"

@interface SXHomeMainSectionFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end


@implementation SXHomeMainSectionFooterView

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
    [self.moreBtn roundViewWithRadius:4.0f];
    [self.moreBtn setTitleColor:SXColor666666 forState:UIControlStateNormal];
    [self.moreBtn setBackgroundColor:SXColorBtnDisabled];
}

#pragma mark -事件监听-
- (IBAction)clickMoreBtn:(UIButton *)sender {
    if (self.clickMoreBtnBlock) {
        self.clickMoreBtnBlock();
    }
}

@end
