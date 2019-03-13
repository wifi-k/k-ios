//
//  SXOnlineBroadbandHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandHeaderView.h"

@interface SXOnlineBroadbandHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@property (weak, nonatomic) IBOutlet UIButton *disconnectedBtn;

@property (weak, nonatomic) IBOutlet UIButton *connectedBtn;

@end

@implementation SXOnlineBroadbandHeaderView

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
    
    self.disconnectedBtn.backgroundColor = SXColorBtnDisabled;
    [self.disconnectedBtn setTitleColor:SXColor666666 forState:UIControlStateNormal];
    
    [self.disconnectedBtn roundViewWithRadius:6.0f];
    [self.connectedBtn roundViewWithRadius:6.0f];
}

- (IBAction)clickDisconnectedBtn:(UIButton *)sender {
    if (self.clickDisconnectedBtnBlock) {
        self.clickDisconnectedBtnBlock();
    }
}

- (IBAction)clickConnectedBtn:(UIButton *)sender {
    if (self.clickConnectedBtnBlock) {
        self.clickConnectedBtnBlock();
    }
}

@end
