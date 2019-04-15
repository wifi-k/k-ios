//
//  SXRegistSetPwdHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistSetPwdHeaderView.h"

@interface SXRegistSetPwdHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXRegistSetPwdHeaderView

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
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView.height = 0.5;
    self.bottomLineView2.height = 0.5;
    
    [self.confirmBtn setTitleColor:SXColorTextDisabled forState:UIControlStateDisabled];
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    
    self.confirmBtn.enabled = NO;
    
    //成为第一响应
    [self.pwdTextField becomeFirstResponder];
    
    self.pwdTextField.tintColor = SXColorBlue2;
    self.pwd2TextField.tintColor = SXColorBlue2;
    
    [self.pwdTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwd2TextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark -按钮点击事件-
- (IBAction)clickVisibleBtn1:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickVisibleBtn2:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwd2TextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickConfirmBtn:(UIButton *)sender {
    
    if (![self.param.passwd2 isEqualToString:self.param.passwd]) {
        [MBProgressHUD showWarningWithMessage:@"两次密码输入不一致,请重输!" toView:SXKeyWindow];
        return;
    }
    
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingPasswordTextField:(UITextField *)sender {
    DLog(@"editingPasswordTextField:%@",sender.text);
    self.bottomLineView.backgroundColor = SXColorBlue;
    self.bottomLineView.height = 1;
    self.param.passwd = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPasswordTextField:(UITextField *)sender {
    DLog(@"endPasswordTextField:%@",sender.text);
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5;
}

- (IBAction)editingPassword2TextField:(UITextField *)sender {
    DLog(@"editingPassword2TextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = SXColorBlue;
    self.bottomLineView2.height = 1;
    self.param.passwd2 = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPassword2TextField:(UITextField *)sender {
    DLog(@"endPassword2TextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.height = 0.5;
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.pwdTextField.text.trim.length && self.pwd2TextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
