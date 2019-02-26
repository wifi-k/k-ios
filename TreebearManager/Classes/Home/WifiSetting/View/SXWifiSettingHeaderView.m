
//
//  SXWifiSettingHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingHeaderView.h"

@interface SXWifiSettingHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *titleL2;
@property (weak, nonatomic) IBOutlet UILabel *nameContentL;
@property (weak, nonatomic) IBOutlet UILabel *pwdContentL;
@property (weak, nonatomic) IBOutlet UILabel *pwdTipsL;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIButton *pwdBtn;
@end

@implementation SXWifiSettingHeaderView

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
    
    self.backgroundColor = SXColorWhite;
    
    self.titleL.font = SXFontBold20;
    self.titleL2.font = SXFontBold20;
    
    self.nameContentL.textColor = SXColor333333;
    self.pwdContentL.textColor = SXColor333333;
    self.pwdTipsL.textColor = SXColor999999;
    
    [self.nameBtn roundViewWithRadius:4.0f];
    
    [self.pwdBtn roundViewWithRadius:4.0f];
    [self.pwdBtn setTitleColor:SXColor333333 forState:UIControlStateNormal];
    [self.pwdBtn setBackgroundColor:SXColorBtnDisabled forState:UIControlStateNormal];
}

- (IBAction)clickNameBtn:(UIButton *)sender {
    if (self.clickWifiNameBlock) {
        self.clickWifiNameBlock();
    }
}

- (IBAction)clickPwdBtn:(UIButton *)sender {
    if (self.clickWifiPasswordBlock) {
        self.clickWifiPasswordBlock();
    }
}


@end
