//
//  SXOnlineFixedIPHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineFixedIPHeaderView.h"
#import "SXXiaoKInfoModel.h"

@interface SXOnlineFixedIPHeaderView ()

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

#pragma mark -getter-
- (SXNetStaticParam *)param{
    if (_param == nil) {
        _param = [[SXNetStaticParam alloc] init];
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
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.ipTextField.backgroundColor = SXColorF6F7FB;
    self.netmaskTextField.backgroundColor = SXColorF6F7FB;
    self.gatewayTextField.backgroundColor = SXColorF6F7FB;
    self.dnsTextField.backgroundColor = SXColorF6F7FB;
    self.dns2TextField.backgroundColor = SXColorF6F7FB;
    
    
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

- (void)setUpData{
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    self.ipTextField.text = shareInfo.gateway;
    self.dnsTextField.text = shareInfo.dns1;
    self.dns2TextField.text = shareInfo.dns2;
}

#pragma mark -Event-
- (IBAction)clickSaveBtn:(UIButton *)sender {
    if (self.clickSaveBtnBlock) {
        self.clickSaveBtnBlock();
    }
}

- (IBAction)editingIPTextField:(UITextField *)sender {
    self.param.ip = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (IBAction)editingNetmaskTextField:(UITextField *)sender {
    self.param.netmask = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (IBAction)editingGatewayTextField:(UITextField *)sender {
    self.param.gateway = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}


- (IBAction)editingDnsTextField:(UITextField *)sender {
    self.param.dns1 = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (IBAction)editingDns2TextField:(UITextField *)sender {
    self.param.dns2 = sender.text.trim.filterSpace;
//    [self changeConfirmBtnEnabled];
}

- (void)changeConfirmBtnEnabled{
    self.saveBtn.enabled = self.param.ip.length && self.param.netmask.length && self.param.gateway.length && self.param.dns1.length && self.param.dns2.length;
}

@end
