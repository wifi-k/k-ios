//
//  SXLoginHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginHeaderView.h"
#import "SXLoginParam.h"
#import "NSString+Hash.h"

@interface SXLoginHeaderView ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine1H;
    
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine2H;

@property (weak, nonatomic) IBOutlet UIButton *codeLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation SXLoginHeaderView

#pragma mark -getter-
- (SXLoginParam *)param{
    if (_param == nil) {
        _param = [[SXLoginParam alloc] init];
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
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView1.height = 0.5;
    self.bottomLineView2.height = 0.5;
    
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.loginBtn roundViewWithRadius:6.0f];
    
    self.loginBtn.enabled = NO;
}

#pragma mark -按钮点击事件-
- (IBAction)clickVisibleBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickCodeLoginBtn:(UIButton *)sender {
    if (self.clickCodeLoginBtnBlock) {
        self.clickCodeLoginBtnBlock();
    }
}
    
- (IBAction)clickForgetBtn:(UIButton *)sender {
    if (self.clickForgetBtnBlock) {
        self.clickForgetBtnBlock();
    }
}
    
- (IBAction)clickLoginBtn:(UIButton *)sender {
    if (self.clickLoginBtnBlock) {
        self.clickLoginBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingPhoneTextField:(UITextField *)sender {
    DLog(@"editingPhoneTextField:%@",sender.text);
    self.bottomLineView1.backgroundColor = SXColorBlue;
    self.bottomLineView1.height = 1;
    self.param.mobile = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPhoneTextField:(UITextField *)sender {
    DLog(@"endPhoneTextField:%@",sender.text);
    self.bottomLineView1.backgroundColor = UIColor.lightGrayColor;
    self.bottomLineView1.height = 0.5;
}

- (IBAction)editingPasswordTextField:(UITextField *)sender {
    DLog(@"editingPasswordTextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = SXColorBlue;
    self.bottomLineView2.height = 1;
    self.param.vcode = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPasswordTextField:(UITextField *)sender {
    DLog(@"endPasswordTextField:%@",sender.text);
    self.bottomLineView2.backgroundColor = UIColor.lightGrayColor;
    self.bottomLineView2.height = 0.5;
}

- (void)changeConfirmBtnEnabled{
    self.loginBtn.enabled = self.phoneTextField.text.trim.length && self.pwdTextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
