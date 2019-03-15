//
//  SXNetStaticHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetStaticHeaderView.h"

@interface SXNetStaticHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property (weak, nonatomic) IBOutlet UILabel *ipTitleL;
@property (weak, nonatomic) IBOutlet UITextField *IPAddressTextField;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;


@property (weak, nonatomic) IBOutlet UILabel *maskCodeTitleL;
@property (weak, nonatomic) IBOutlet UITextField *maskCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;


@property (weak, nonatomic) IBOutlet UILabel *gatewayTitleL;
@property (weak, nonatomic) IBOutlet UITextField *gatewayTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdLineView;


@property (weak, nonatomic) IBOutlet UILabel *firstDNSTitleL;
@property (weak, nonatomic) IBOutlet UITextField *firstNDSTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthLineView;


@property (weak, nonatomic) IBOutlet UILabel *secondDNSTitleL;
@property (weak, nonatomic) IBOutlet UITextField *secondDNSTextField;
@property (weak, nonatomic) IBOutlet UIView *fifthLineView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXNetStaticHeaderView

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
    
    self.titleL.text = @"静态IP上网";
    self.titleL.textColor = SXColor333333;
    self.titleL.font = SXFontBold18;
    
    self.ipTitleL.textColor = SXColor999999;
    self.maskCodeTitleL.textColor = SXColor999999;
    self.gatewayTitleL.textColor = SXColor999999;
    self.firstDNSTitleL.textColor = SXColor999999;
    self.secondDNSTitleL.textColor = SXColor999999;
    
    self.IPAddressTextField.backgroundColor = SXColorF6F7FB;
    self.maskCodeTextField.backgroundColor = SXColorF6F7FB;
    self.gatewayTextField.backgroundColor = SXColorF6F7FB;
    self.firstNDSTextField.backgroundColor = SXColorF6F7FB;
    self.secondDNSTextField.backgroundColor = SXColorF6F7FB;
    
    //1.填补视图
    UIImageView *leftImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV1.contentMode = UIViewContentModeCenter;
    self.IPAddressTextField.leftView = leftImageV1;
    self.IPAddressTextField.leftViewMode = UITextFieldViewModeAlways;
    //2.填补视图
    UIImageView *leftImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV2.contentMode = UIViewContentModeCenter;
    self.maskCodeTextField.leftView = leftImageV2;
    self.maskCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //3.填补视图
    UIImageView *leftImageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV3.contentMode = UIViewContentModeCenter;
    self.gatewayTextField.leftView = leftImageV3;
    self.gatewayTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //4.填补视图
    UIImageView *leftImageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV4.contentMode = UIViewContentModeCenter;
    self.firstNDSTextField.leftView = leftImageV4;
    self.firstNDSTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //5.填补视图
    UIImageView *leftImageV5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV5.contentMode = UIViewContentModeCenter;
    self.secondDNSTextField.leftView = leftImageV5;
    self.secondDNSTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.firstLineView.backgroundColor = SXColorDivideLine;
    self.secondLineView.backgroundColor = SXColorDivideLine;
    self.thirdLineView.backgroundColor = SXColorDivideLine;
    self.fourthLineView.backgroundColor = SXColorDivideLine;
    self.fifthLineView.backgroundColor = SXColorDivideLine;

    self.firstLineView.height = 0.1;
    self.secondLineView.height = 0.1;
    self.thirdLineView.height = 0.1;
    self.fourthLineView.height = 0.1;
    self.fifthLineView.height = 0.1;
    
    self.firstLineView.hidden = YES;
    self.secondLineView.hidden = YES;
    self.thirdLineView.hidden = YES;
    self.fourthLineView.hidden = YES;
    self.fifthLineView.hidden = YES;
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    self.confirmBtn.enabled = NO;
    
    //成为第一响应
    [self.IPAddressTextField becomeFirstResponder];
    
    //设置默认值
    self.param.ip = @"";
    self.param.netmask = @"";
    self.param.gateway = @"";
    self.param.dns1 = @"";
    self.param.dns2 = @"";
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    [self endEditing:YES];
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

#pragma mark -文本编辑-
- (IBAction)editingIPAddressTextField:(UITextField *)sender {
    self.param.ip = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)editingMaskCodeTextField:(UITextField *)sender {
    self.param.netmask = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}


- (IBAction)editingGatewayTextField:(UITextField *)sender {
    self.param.gateway = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)editingFirstTextField:(UITextField *)sender {
    self.param.dns1 = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)editingSecondDNSTextField:(UITextField *)sender {
    self.param.dns2 = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.param.ip.length && self.param.netmask.length && self.param.gateway.length && self.param.dns1.length && self.param.dns2.length;
}

@end
