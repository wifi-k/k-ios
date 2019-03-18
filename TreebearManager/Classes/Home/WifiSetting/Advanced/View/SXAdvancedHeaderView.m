//
//  SXAdvancedHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAdvancedHeaderView.h"

@interface SXAdvancedHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *broadcastTitleL;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *channelTitleL;
@property (weak, nonatomic) IBOutlet UILabel *channelL;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *workModelTitleL;
@property (weak, nonatomic) IBOutlet UILabel *workModeL;
@property (weak, nonatomic) IBOutlet UIView *thirdLineView;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *frequencyTitleL;
@property (weak, nonatomic) IBOutlet UILabel *frequencyL;
@property (weak, nonatomic) IBOutlet UIView *fourthLineView;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SXAdvancedHeaderView

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
    
    self.firstLineView.backgroundColor = SXColorDivideLine;
    self.secondLineView.backgroundColor = SXColorDivideLine;
    self.thirdLineView.backgroundColor = SXColorDivideLine;
    self.fourthLineView.backgroundColor = SXColorDivideLine;
    
    self.firstLineView.height = 0.5;
    self.secondLineView.height = 0.5;
    self.thirdLineView.height = 0.5;
    self.fourthLineView.height = 0.1;

    self.broadcastTitleL.textColor = SXColor333333;
    self.channelTitleL.textColor = SXColor333333;
    self.workModelTitleL.textColor = SXColor333333;
    self.frequencyTitleL.textColor = SXColor333333;
    
    self.channelL.textColor = SXColor999999;
    self.workModeL.textColor = SXColor999999;
    self.frequencyL.textColor = SXColor999999;
    
    //缩放
    //self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColorBlue2;
    
    [self.saveBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.saveBtn roundViewWithRadius:6.0f];
    self.saveBtn.hidden = YES;
    
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView:)];
    [self.secondBgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView:)];
    [self.thirdBgView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView:)];
    [self.fourthBgView addGestureRecognizer:tap3];
}

#pragma mark -setter-
- (void)setParam:(SXAdvancedOptionParam *)param{
    _param = param;
    
    self.switchBtn.on = param.selected.boolValue;
    self.channelL.text = param.title1;
    self.workModeL.text = param.title2;
    self.frequencyL.text = param.title3;
}

#pragma mark -点击事件-
- (IBAction)clickSaveBtn:(UIButton *)sender {
//    if (self.clickSaveBtnBlock) {
//        self.clickSaveBtnBlock();
//    }
}

- (void)clickBgView:(UITapGestureRecognizer *)tap{
    if (self.clickBgBlock) {
        self.clickBgBlock(tap.view.tag - 10);
    }
}

@end
