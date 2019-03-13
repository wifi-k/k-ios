//
//  SXOnlineAutotIPHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineAutotIPHeaderView.h"

@interface SXOnlineAutotIPHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *connectStatusTitleL;
@property (weak, nonatomic) IBOutlet UILabel *connectStatusL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *ipAddressTitleL;
@property (weak, nonatomic) IBOutlet UILabel *ipAddressL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *maskTitleL;
@property (weak, nonatomic) IBOutlet UILabel *maskL;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *gatewayTitleL;
@property (weak, nonatomic) IBOutlet UILabel *gatewayL;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UILabel *dnsTitleL;
@property (weak, nonatomic) IBOutlet UILabel *dnsL;
@property (weak, nonatomic) IBOutlet UIView *fifthBgView;


@property (weak, nonatomic) IBOutlet UILabel *dns2TitleL;
@property (weak, nonatomic) IBOutlet UILabel *dns2L;
@property (weak, nonatomic) IBOutlet UIView *sixthBgView;

@property (weak, nonatomic) IBOutlet UILabel *advancedTitleL;
@property (weak, nonatomic) IBOutlet UIView *divideLineView;
@property (weak, nonatomic) IBOutlet UIView *seventhBgView;

@property (weak, nonatomic) IBOutlet UIButton *updateIPBtn;

@end

@implementation SXOnlineAutotIPHeaderView

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
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    self.fifthBgView.backgroundColor = SXColorWhite;
    self.sixthBgView.backgroundColor = SXColorWhite;
    self.seventhBgView.backgroundColor = SXColorWhite;
    
    self.connectStatusTitleL.textColor = SXColor999999;
    self.ipAddressTitleL.textColor = SXColor999999;
    self.maskTitleL.textColor = SXColor999999;
    self.gatewayTitleL.textColor = SXColor999999;
    self.dnsTitleL.textColor = SXColor999999;
    self.dns2TitleL.textColor = SXColor999999;
    
    self.connectStatusL.textColor = SXColor333333;
    self.ipAddressL.textColor = SXColor333333;
    self.maskL.textColor = SXColor333333;
    self.gatewayL.textColor = SXColor333333;
    self.dnsL.textColor = SXColor333333;
    self.dns2L.textColor = SXColor333333;
    
    self.divideLineView.backgroundColor = SXColorDivideLine;
    self.divideLineView.height = 0.5f;
    
    self.advancedTitleL.textColor = SXColor333333;
    self.advancedTitleL.font = SXFontBold18;
    
    //1.1添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdvancedBgView)];
    [self.seventhBgView addGestureRecognizer:tap];
    
    self.updateIPBtn.backgroundColor = SXColorWhite;
    [self.updateIPBtn roundViewWithRadius:22.5f borderColor:SXColorDivideLine borderWidth:1.0f];
}

#pragma mark -点击事件-
- (IBAction)clickUpdateIPBtn:(UIButton *)sender {
    if (self.clickUpdateIPBtnBlock) {
        self.clickUpdateIPBtnBlock();
    }
}

- (void)clickAdvancedBgView{
    if (self.clickAdvancedBgViewBlock) {
        self.clickAdvancedBgViewBlock();
    }
}

@end