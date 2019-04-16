//
//  SXHealtyControlHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlHeaderView.h"

@interface SXHealtyControlHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *healthTitleL;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@end

@implementation SXHealtyControlHeaderView

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
    
//    self.topImageView.contentMode = UIViewContentModeCenter;
    
    self.healthTitleL.textColor = SXColor2B3852;
    self.healthTitleL.font = SXFontBold20;
    self.timeL.textColor = SXColor2B3852;
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    
    //缩放
//    self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColorBlue2;
}

#pragma mark -setter-
- (void)setOp:(NSNumber *)op{
    _op = op;
    
    self.switchBtn.on = op.boolValue;
}

- (NSNumber *)isSwitchOn{
    return self.switchBtn.isOn ? @1 :@0;
}

#pragma mark -点击事件-
- (IBAction)clickSwitchBtn:(UISwitch *)sender {
    if (self.clickSwitchBtnBlock) {
        self.clickSwitchBtnBlock(sender.isOn);
    }
}

@end
