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
    
    //登录按钮
    [self.loginBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorGray8 forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [self.loginBtn roundViewWithRadius:27.0f];
    
    //注册按钮
//    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.registBtn setBackgroundColor:[UIColor hex:@"1FEAE7"] forState:UIControlStateNormal];
    [self.registBtn roundViewWithRadius:27.0f];
}

- (void)hideIcons:(BOOL)isHidden{
    self.iconImageV.hidden = isHidden;
    self.loginBtn.hidden = isHidden;
    self.registBtn.hidden = isHidden;
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
