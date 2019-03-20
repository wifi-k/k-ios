//
//  SXOnlineFixedIPHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineFixedIPHeaderView.h"

@interface SXOnlineFixedIPHeaderView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;


@property (weak, nonatomic) IBOutlet UITextField *netmaskTextField;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UITextField *gatewayTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;


@property (weak, nonatomic) IBOutlet UITextField *dnsTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;


@property (weak, nonatomic) IBOutlet UITextField *dns2TextField;
@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation SXOnlineFixedIPHeaderView

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
    
    self.ipTextField.backgroundColor = SXColorF6F7FB;
    self.netmaskTextField.backgroundColor = SXColorF6F7FB;
    self.gatewayTextField.backgroundColor = SXColorF6F7FB;
    self.dnsTextField.backgroundColor = SXColorF6F7FB;
    self.dns2TextField.backgroundColor = SXColorF6F7FB;
    
    self.dnsTextField.delegate = self;
    self.dns2TextField.delegate = self;
    
    
    self.ipTextField.leftViewMode = UITextFieldViewModeAlways;
    self.ipTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.netmaskTextField.leftViewMode = UITextFieldViewModeAlways;
    self.netmaskTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.gatewayTextField.leftViewMode = UITextFieldViewModeAlways;
    self.gatewayTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.dnsTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dnsTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.dns2TextField.leftViewMode = UITextFieldViewModeAlways;
    self.dns2TextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    self.fifthBgView.backgroundColor = SXColorWhite;
    
    [self.saveBtn roundViewWithRadius:6.0f];
}

#pragma mark -Event-
- (IBAction)clickSaveBtn:(UIButton *)sender {
    if (self.clickSaveBtnBlock) {
        self.clickSaveBtnBlock();
    }
}

#pragma mark -delegate-
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

@end
