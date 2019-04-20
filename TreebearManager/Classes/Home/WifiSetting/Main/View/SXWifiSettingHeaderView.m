
//
//  SXWifiSettingHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingHeaderView.h"
#import "SXWifiSettingButton.h"
#import "SXXiaoKInfoModel.h"
#import "XKGetWifiNetTool.h"

@interface SXWifiSettingHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *titleL2;
@property (weak, nonatomic) IBOutlet UILabel *nameContentL;
@property (weak, nonatomic) IBOutlet UILabel *pwdContentL;
@property (weak, nonatomic) IBOutlet UILabel *nameTipsL;
@property (weak, nonatomic) IBOutlet UILabel *pwdTipsL;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIButton *pwdBtn;

@property (weak, nonatomic) IBOutlet UIView *firstBgView;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

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
    
    [self setUpData];
}

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.titleL.font = SXFontBold20;
    self.titleL2.font = SXFontBold20;
    
    self.nameContentL.textColor = SXColor2B3852;
    self.pwdContentL.textColor = SXColor2B3852;
    self.pwdTipsL.textColor = SXColor7383A2;
    self.nameTipsL.textColor = SXColor7383A2;
    
    [self.nameBtn roundViewWithRadius:4.0f];
    [self.nameBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.nameBtn setBackgroundColor:SXColorF7F7F7 forState:UIControlStateNormal];
    
    [self.pwdBtn roundViewWithRadius:4.0f];
    [self.pwdBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.pwdBtn setBackgroundColor:SXColorF7F7F7 forState:UIControlStateNormal];
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    
    self.nameTipsL.text = @"当前WiFi名称:";
}

- (void)setUpData{
    if ([NSString isNotEmpty:SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId]) {
        NSString *name = [XKGetWifiNetTool getWifiSSID];
        self.nameTipsL.text = [NSString stringWithFormat:@"当前WiFi名称:%@",name];
    }
}

#pragma mark -点击事件-
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

- (IBAction)clickAdvancedBtn:(SXWifiSettingButton *)sender {
    if (self.clickAdvancedBtnBlock) {
        self.clickAdvancedBtnBlock(sender.tag);
    }
}

@end
