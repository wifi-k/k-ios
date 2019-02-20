//
//  SXForgetHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetHeaderView.h"
#import "SXLoginCertifyCodeButton.h"

@interface SXForgetHeaderView ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineVH;
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineV2H;
@property (weak, nonatomic) IBOutlet UIButton *clickNextBtn;
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
    
    [self.clickNextBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.clickNextBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.clickNextBtn roundViewWithRadius:6.0f];
    
    self.clickNextBtn.enabled = NO;
}

#pragma mark -按钮点击事件-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    [sender start];
}

- (IBAction)clickNextBtn:(UIButton *)sender {
    if (self.clickNextBtnBlock) {
        self.clickNextBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingPhoneTextField:(UITextField *)sender {
    DLog(@"editingPhoneTextField:%@",sender.text);
    self.bottomLineV.backgroundColor = SXColorBlue;
    self.param.mobile = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
    if (!self.codeBtn.isCounting) {//非计时状态，改变按钮状态
        self.codeBtn.enabled = self.param.mobile.isPhoneNumber;
    }
}

- (IBAction)endPhoneTextField:(UITextField *)sender {
    DLog(@"endPhoneTextField:%@",sender.text);
    self.bottomLineV.backgroundColor = UIColor.lightGrayColor;
}

- (IBAction)editingCodeTextField:(UITextField *)sender {
    DLog(@"editingCodeTextField:%@",sender.text);
    self.bottomLineV2.backgroundColor = SXColorBlue;
    self.param.vcode = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endCodeTextField:(UITextField *)sender {
    DLog(@"endCodeTextField:%@",sender.text);
    self.bottomLineV2.backgroundColor = UIColor.lightGrayColor;
}

- (void)changeConfirmBtnEnabled{
    self.clickNextBtn.enabled = self.phoneTextField.text.trim.length && self.codeTextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
