//
//  SXDHCPServerHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDHCPServerHeaderView.h"

@interface SXDHCPServerHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *switchOnBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchOffBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchAutoBtn;
@property (weak, nonatomic) IBOutlet UIView *dhcpSwitchBgView;
@property (weak, nonatomic) IBOutlet UILabel *firstTitleL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *secondTitleL;
@property (weak, nonatomic) IBOutlet UITextField *addressBeginTextField;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *thirdTitleL;
@property (weak, nonatomic) IBOutlet UITextField *addressEndTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *fourthTitleL;
@property (weak, nonatomic) IBOutlet UITextField *addressTermTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UILabel *fifthTitleL;
@property (weak, nonatomic) IBOutlet UITextField *maskTextField;
@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@property (weak, nonatomic) IBOutlet UILabel *sixthTitleL;
@property (weak, nonatomic) IBOutlet UITextField *dnsTextField;
@property (weak, nonatomic) IBOutlet UIView *sixthBgView;

@property (weak, nonatomic) IBOutlet UILabel *seventhTitleL;
@property (weak, nonatomic) IBOutlet UITextField *dns2TextField;
@property (weak, nonatomic) IBOutlet UIView *seventhBgView;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
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
    
    self.firstTitleL.textColor = SXColor333333;
    self.secondTitleL.textColor = SXColor333333;
    self.thirdTitleL.textColor = SXColor333333;
    self.fourthTitleL.textColor = SXColor333333;
    self.fifthTitleL.textColor = SXColor333333;
    self.sixthTitleL.textColor = SXColor333333;
    self.seventhTitleL.textColor = SXColor333333;
    
    self.addressBeginTextField.backgroundColor = SXColorF6F7FB;
    self.addressEndTextField.backgroundColor = SXColorF6F7FB;
    self.addressTermTextField.backgroundColor = SXColorF6F7FB;
    self.maskTextField.backgroundColor = SXColorF6F7FB;
    self.dnsTextField.backgroundColor = SXColorF6F7FB;
    self.dns2TextField.backgroundColor = SXColorF6F7FB;
    
    self.addressBeginTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.addressBeginTextField.leftViewMode = UITextFieldViewModeAlways;
    self.addressEndTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.addressEndTextField.leftViewMode = UITextFieldViewModeAlways;
    self.addressTermTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.addressTermTextField.leftViewMode = UITextFieldViewModeAlways;
    self.maskTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.maskTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dnsTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.dnsTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dns2TextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    self.dns2TextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.saveBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.saveBtn roundViewWithRadius:6.0f];
    
    [self.addressBeginTextField becomeFirstResponder];
    
    //默认选中
    self.switchOnBtn.selected = YES;
}

#pragma mark -点击事件-
- (IBAction)clickSwitchBtn:(UIButton *)sender {
    for (UIButton *btn in self.dhcpSwitchBgView.subviews) {
        btn.selected = NO;
    }
    
    sender.selected = YES;
}


- (IBAction)clickSaveBtn:(UIButton *)sender {
    if (self.clickSaveBtnBlock) {
        self.clickSaveBtnBlock();
    }
}

@end
