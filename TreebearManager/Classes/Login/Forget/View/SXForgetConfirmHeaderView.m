//
//  SXForgetConfirmHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetConfirmHeaderView.h"
#import "NSString+Hash.h"

@interface SXForgetConfirmHeaderView ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
    
@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
    
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *licence;
@end

@implementation SXForgetConfirmHeaderView

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
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
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
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}
 
- (IBAction)clickAgreeBtn:(UIButton *)sender {
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
- (IBAction)editingPasswordTextField:(UITextField *)sender {
    DLog(@"editingPasswordTextField:%@",sender.text);
    self.bottomLineView.backgroundColor = SXColorBlue;
    self.param.mobile = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPasswordTextField:(UITextField *)sender {
    DLog(@"endPasswordTextField:%@",sender.text);
    self.bottomLineView.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)editingPassword2TextField:(UITextField *)sender {
    DLog(@"editingPassword2TextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = SXColorBlue;
    self.param.code = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPassword2TextField:(UITextField *)sender {
    DLog(@"endPassword2TextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = UIColor.lightGrayColor;
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.pwdTextField.text.trim.length && self.pwd2TextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
