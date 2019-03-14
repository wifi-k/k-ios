//
//  SXMobileUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileUpdateHeaderView.h"
#import "SXLoginCertifyCodeButton.h"

@interface SXMobileUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@end

@implementation SXMobileUpdateHeaderView

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

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView1.height = 0.5f;
    self.bottomLineView2.height = 0.5f;
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    self.confirmBtn.enabled = NO;
    
    self.codeBtn.enabled = NO;
    
    //成为第一响应
    [self.mobileTextField becomeFirstResponder];
}

#pragma mark -Event-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

@end
