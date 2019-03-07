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

@property (weak, nonatomic) IBOutlet UIButton *addTimeBtn;
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
    
    self.healthTitleL.textColor = SXColor333333;
    self.timeL.textColor = SXColor333333;
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    
    //缩放
//    self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColorBlue2;
    
    [self.addTimeBtn roundViewWithRadius:22.5f];
}

#pragma mark -点击事件-
- (IBAction)clickEditBtn:(UIButton *)sender {
    if (self.clickEditTimeBlock) {
        self.clickEditTimeBlock();
    }
}

- (IBAction)clickAddBtn:(UIButton *)sender {
    if (self.clickAddTimeBlock) {
        self.clickAddTimeBlock();
    }
}

@end
