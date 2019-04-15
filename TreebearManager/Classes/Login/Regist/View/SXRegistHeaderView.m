//
//  SXRegistHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistHeaderView.h"
#import "SXLoginCertifyCodeButton.h"
#import "SXLoginNetTool.h"

@interface SXRegistHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineVH;
    
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineV2H;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *licence;
@end

@implementation SXRegistHeaderView

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
    self.titleL.font = SXFontBold24;
    self.titleL.textColor = SXColor2B3852;
    
    self.bottomLineV.backgroundColor = SXColorDivideLine;
    self.bottomLineV2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineV.height = 0.5;
    self.bottomLineV2.height = 0.5;
    
    self.codeBtn.enabled = NO;
    
    [self.registBtn setTitleColor:SXColorTextDisabled forState:UIControlStateDisabled];
    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateDisabled];
    [self.registBtn roundViewWithRadius:6.0f];
    self.registBtn.enabled = NO;
    
    self.codeBtn.enabled = NO;
    
    //成为第一响应
    [self.phoneTextField becomeFirstResponder];
    
    self.phoneTextField.tintColor = SXColorBlue2;
    self.codeTextField.tintColor = SXColorBlue2;
}

#pragma mark -按钮点击事件-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    WS(weakSelf);
    NSString *mobile = self.phoneTextField.text.filterSpace;
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.type = @1;
    [SXLoginNetTool getCodeDataWithParams:param.mj_keyValues Success:^(NSString * _Nonnull code) {
        [MBProgressHUD showSuccessWithMessage:@"发送成功!" toView:SXKeyWindow];
        //开始计时
        [sender start];
        //成为第一响应
        [weakSelf.codeTextField becomeFirstResponder];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (IBAction)clickRegistBtn:(UIButton *)sender {
    if (!self.agreeBtn.selected) {
        [MBProgressHUD showWarningWithMessage:@"请选择同意用户协议!" toView:SXKeyWindow];
        return;
    }
    
    WS(weakSelf);
    NSString *mobile = self.phoneTextField.text.filterSpace;
    NSString *vcode = self.codeTextField.text.filterSpace;
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.vcode = vcode;
    [SXLoginNetTool registUserInfoDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showMessageToWindow:@"请继续完成密码设置!"];
        
        if (weakSelf.registSuccessBlock) {
            weakSelf.registSuccessBlock();
        }
    } failure:^(NSError * _Nonnull error) {
        if (error.code == 9) {//该手机号已注册，请立即登录
            [self endEditing:YES];
            if (weakSelf.alertLoginTipsBlock) {
                weakSelf.alertLoginTipsBlock();
            }
        } else{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

- (IBAction)clickAgreeBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.clickAgreeBtnBlock) {
        self.clickAgreeBtnBlock();
    }
}

- (IBAction)clickLicenceBtn:(UIButton *)sender {
    if (self.clickLicenceBtnBlock) {
        self.clickLicenceBtnBlock();
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)changeConfirmBtnEnabled{
    self.registBtn.enabled = self.phoneTextField.text.trim.length && self.codeTextField.text.trim.length;
}

@end
