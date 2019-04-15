//
//  SXOnlineBroadbandHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandHeaderView.h"
#import "SXXiaoKInfoModel.h"

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

#pragma mark -getter-
- (SXNetBroadbandParam *)param{
    if (_param == nil) {
        _param = [[SXNetBroadbandParam alloc] init];
    }
    return _param;
}

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    [self setUpUI];
    
    [self setUpData];
}

- (void)setUpData{
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    self.ipTextField.text = shareInfo.ip;
    self.dnsTextField.text = shareInfo.dns1;
    self.dns2TextField.text = shareInfo.dns2;
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
    [self.disconnectedBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    
    [self.disconnectedBtn roundViewWithRadius:6.0f];
    [self.connectedBtn roundViewWithRadius:6.0f];
    
    [self.broadbandTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.bandPwdTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.ipTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.dnsTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.dns2TextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    
    self.broadbandTextField.tintColor = SXColorBlue2;
    self.bandPwdTextField.tintColor = SXColorBlue2;
    self.ipTextField.tintColor = SXColorBlue2;
    self.dnsTextField.tintColor = SXColorBlue2;
    self.dns2TextField.tintColor = SXColorBlue2;
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

#pragma mark -Event-
- (IBAction)editingBandAccountTextField:(UITextField *)sender {
    DLog(@"editingBandAccountTextField:%@",sender.text);
    self.param.name = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (IBAction)editingBandPasswordTextField:(UITextField *)sender {
    DLog(@"editingBandPasswordTextField:%@",sender.text);
    self.param.passwd = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (void)changeConfirmBtnEnabled{
    self.connectedBtn.enabled = self.broadbandTextField.text.trim.length && self.bandPwdTextField.text.trim.length;
}

@end
