//
//  SXForgetHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetHeaderView.h"
#import "SXLoginCertifyCodeButton.h"
#import "SXLoginNetTool.h"

@interface SXForgetHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *naviTitleL;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineVH;
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineV2H;
@property (weak, nonatomic) IBOutlet UIButton *clickNextBtn;

@property (copy, nonatomic) NSString *vcode;//网络验证码
@end

@implementation SXForgetHeaderView

#pragma mark -getter-
- (SXRegistParam *)param{
    if (_param == nil) {
        _param = [[SXRegistParam alloc] init];
    }
    return _param;
}

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
    
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}
    
- (void)setUpUI{
    
    self.naviTitleL.font = SXFontBold24;
    self.naviTitleL.textColor = SXColor2B3852;
    
    self.bottomLineV.backgroundColor = SXColorDivideLine;
    self.bottomLineV2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineV.height = 0.5;
    self.bottomLineV2.height = 0.5;
    
    [self.clickNextBtn setTitleColor:SXColorTextDisabled forState:UIControlStateDisabled];
    [self.clickNextBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateDisabled];
    [self.clickNextBtn roundViewWithRadius:6.0f];
    
    self.clickNextBtn.enabled = NO;
    
    self.codeBtn.enabled = NO;
    
    //成为第一响应
    [self.phoneTextField becomeFirstResponder];
    
    self.phoneTextField.tintColor = SXColorBlue2;
    self.codeTextField.tintColor = SXColorBlue2;
    
    [self.phoneTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark -按钮点击事件-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    WS(weakSelf);
    NSString *mobile = self.phoneTextField.text.filterSpace;
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.type = @2;
    [SXLoginNetTool getCodeDataWithParams:param.mj_keyValues Success:^(NSString * _Nonnull code) {
        [MBProgressHUD showSuccessWithMessage:@"发送成功!" toView:SXKeyWindow];
        //开始计时
        [sender start];
        //成为第一响应
        [weakSelf.codeTextField becomeFirstResponder];
        //赋值验证码
        weakSelf.vcode = code;
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (IBAction)clickNextBtn:(UIButton *)sender {
    if ([NSString isEmpty:self.vcode]) {
        [MBProgressHUD showWarningWithMessage:@"请点击获取验证码!" toView:SXKeyWindow];
        return;
    }
    
    if (![self.vcode isEqualToString:self.param.vcode]) {
        [MBProgressHUD showWarningWithMessage:@"您输入的验证码不对,请重输!" toView:SXKeyWindow];
        return;
    }
    
    //赋值，保证验证码正确
    self.param.vcode = self.vcode;
    
    if (self.clickNextBtnBlock) {
        self.clickNextBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingPhoneTextField:(UITextField *)sender {
    DLog(@"editingPhoneTextField:%@",sender.text);
    self.bottomLineV.backgroundColor = SXColorBlue;
    self.bottomLineV.height = 1;
    self.param.mobile = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
    if (!self.codeBtn.isCounting) {//非计时状态，改变按钮状态
        self.codeBtn.enabled = self.param.mobile.isPhoneNumber;
    }
}

- (IBAction)endPhoneTextField:(UITextField *)sender {
    DLog(@"endPhoneTextField:%@",sender.text);
    self.bottomLineV.backgroundColor = SXColorDivideLine;
    self.bottomLineV.height = 0.5;
}

- (IBAction)editingCodeTextField:(UITextField *)sender {
    DLog(@"editingCodeTextField:%@",sender.text);
    self.bottomLineV2.backgroundColor = SXColorBlue;
    self.bottomLineV2.height = 1;
    self.param.vcode = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endCodeTextField:(UITextField *)sender {
    DLog(@"endCodeTextField:%@",sender.text);
    self.bottomLineV2.backgroundColor = SXColorDivideLine;
    self.bottomLineV2.height = 0.5;
}

- (void)changeConfirmBtnEnabled{
    self.clickNextBtn.enabled = self.phoneTextField.text.trim.length && self.codeTextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
