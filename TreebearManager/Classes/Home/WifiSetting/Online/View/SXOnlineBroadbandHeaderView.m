//
//  SXOnlineBroadbandHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandHeaderView.h"

@interface SXOnlineBroadbandHeaderView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *broadbandTextField;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UITextField *bandPwdTextField;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UITextField *dnsTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UIButton *disconnectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *connectedBtn;
@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@property (weak, nonatomic) IBOutlet UITextField *dns2TextField;
@property (weak, nonatomic) IBOutlet UIView *sixthBgView;

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

    self.broadbandTextField.backgroundColor = SXColorF6F7FB;
    self.bandPwdTextField.backgroundColor = SXColorF6F7FB;
    self.ipTextField.backgroundColor = SXColorWhite;
    self.dnsTextField.backgroundColor = SXColorWhite;
    self.dns2TextField.backgroundColor = SXColorWhite;
    
    self.ipTextField.delegate = self;
    self.dnsTextField.delegate = self;
    self.dns2TextField.delegate = self;
    
    self.broadbandTextField.leftViewMode = UITextFieldViewModeAlways;
    self.broadbandTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.bandPwdTextField.leftViewMode = UITextFieldViewModeAlways;
    self.bandPwdTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.ipTextField.leftViewMode = UITextFieldViewModeAlways;
    self.ipTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.dnsTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dnsTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.dns2TextField.leftViewMode = UITextFieldViewModeAlways;
    self.dns2TextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    self.fifthBgView.backgroundColor = SXColorWhite;
    self.sixthBgView.backgroundColor = SXColorWhite;
    
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

#pragma mark -delegate-
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

@end
