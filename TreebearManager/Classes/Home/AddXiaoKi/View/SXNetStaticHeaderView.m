//
//  SXNetStaticHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetStaticHeaderView.h"

@interface SXNetStaticHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstLineView;

@property (weak, nonatomic) IBOutlet UIView *secondLineView;

@property (weak, nonatomic) IBOutlet UIView *thirdLineView;

@property (weak, nonatomic) IBOutlet UIView *fourthLineView;

@property (weak, nonatomic) IBOutlet UIView *fifthLineView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXNetStaticHeaderView

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
    
    self.firstLineView.backgroundColor = SXColorDivideLine;
    self.secondLineView.backgroundColor = SXColorDivideLine;
    self.thirdLineView.backgroundColor = SXColorDivideLine;
    self.fourthLineView.backgroundColor = SXColorDivideLine;
    self.fifthLineView.backgroundColor = SXColorDivideLine;
    
    self.firstLineView.height = 0.5;
    self.secondLineView.height = 0.5;
    self.thirdLineView.height = 0.5;
    self.fourthLineView.height = 0.5;
    self.fifthLineView.height = 0.5;
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    
//    self.confirmBtn.enabled = NO;
    
    //成为第一响应
//    [self.broadAccountTextField becomeFirstResponder];
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

@end
