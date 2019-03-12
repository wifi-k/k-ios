//
//  SXDHCPServerHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDHCPServerHeaderView.h"

@interface SXDHCPServerHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@property (weak, nonatomic) IBOutlet UIView *sixthBgView;

@property (weak, nonatomic) IBOutlet UIView *seventhBgView;

@end

@implementation SXDHCPServerHeaderView

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
    
    [self.saveBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.saveBtn roundViewWithRadius:6.0f];
}

#pragma mark -点击事件-
- (IBAction)clickSaveBtn:(UIButton *)sender {
    if (self.clickSaveBtnBlock) {
        self.clickSaveBtnBlock();
    }
}


@end
