//
//  SXMobileUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileUpdateHeaderView.h"
#import "SXLoginCertifyCodeButton.h"
#import "SXLoginNetTool.h"

@interface SXMobileUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (copy, nonatomic) NSString *vcode;//网络验证码
@end

@implementation SXMobileUpdateHeaderView

#pragma mark -getter-
- (SXLoginParam *)param{
    if (_param == nil) {
        _param = [SXLoginParam param];
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

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView1.height = 0.5f;
    self.bottomLineView2.height = 0.5f;
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    self.confirmBtn.enabled = NO;
    
    self.codeBtn.enabled = NO;
    
    //成为第一响应
    [self.mobileTextField becomeFirstResponder];
    
    self.codeTextField.tintColor = SXColorBlue2;
    self.mobileTextField.tintColor = SXColorBlue2;
    
    [self.codeTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.mobileTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark -Event-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    WS(weakSelf);
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = self.param.mobile;
    param.type = @3;
    [SXLoginNetTool getCodeDataWithParams:param.mj_keyValues Success:^(NSString * _Nonnull code) {
        [MBProgressHUD showSuccessWithMessage:@"发送成功!" toView:SXKeyWindow];
        //开始计时
        [sender start];
        //成为第一响应
        [weakSelf.codeTextField becomeFirstResponder];
        //赋值验证码
        weakSelf.vcode = code;
        //60S之后清空
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.vcode = @"";
        });
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

- (IBAction)clickConfirmBtn:(UIButton *)sender {
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
    
    //通知回调
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock(self.param);
    }
}

#pragma mark -Event-
- (IBAction)editingMobileTextField:(UITextField *)sender {
    DLog(@"editingMobileTextField:%@",sender.text);
    self.param.mobile = sender.text.filterSpace;
    [self changeConfirmBtnEnabled];
    if (!self.codeBtn.isCounting) {//非计时状态，改变按钮状态
        self.codeBtn.enabled = self.param.mobile.isPhoneNumber;
    }
}

- (IBAction)editingVCodeTextField:(UITextField *)sender {
    DLog(@"editingVCodeTextField:%@",sender.text);
    self.param.vcode = sender.text.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.mobileTextField.text.trim.length && self.codeTextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
