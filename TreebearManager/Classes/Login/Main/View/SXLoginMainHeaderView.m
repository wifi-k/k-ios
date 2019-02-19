//
//  SXLoginMainHeaderView.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginMainHeaderView.h"

@interface SXLoginMainHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation SXLoginMainHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.iconImageV.backgroundColor = SXColorBtnHighlight;
    [self.iconImageV roundViewWithRadius:40.0f];
    
    [self.loginBtn setTitleColor:SXColorGray5 forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorGray8 forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [self.loginBtn roundViewWithRadius:22.5];
    
    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.registBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [self.registBtn roundViewWithRadius:22.5];
}

#pragma mark -按钮点击事件-
- (IBAction)clickLoginBtn:(UIButton *)sender {
    if (self.clickLoginBtnBlock) {
        self.clickLoginBtnBlock();
    }
}

- (IBAction)clickForgetBtn:(UIButton *)sender {
    if (self.clickRegistBtnBlock) {
        self.clickRegistBtnBlock();
    }
}

@end
