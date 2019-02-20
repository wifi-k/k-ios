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
    self.titleL.font = SXFontBold20;
    
    self.codeBtn.enabled = NO;
    
    [self.registBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.registBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.registBtn roundViewWithRadius:6.0f];
    
    self.registBtn.enabled = NO;
}

#pragma mark -按钮点击事件-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    NSString *mobile = self.phoneTextField.text.filterSpace;
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.type = @1;
    [SXLoginNetTool getCodeDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"发送成功!" toView:SXKeyWindow];
        //开始计时
        [sender start];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (IBAction)clickRegistBtn:(UIButton *)sender {
    
    NSString *mobile = self.phoneTextField.text.filterSpace;
    NSString *vcode = self.codeTextField.text.filterSpace;
    SXLoginParam *param = [SXLoginParam param];
    param.mobile = mobile;
    param.vcode = vcode;
    [SXLoginNetTool registUserInfoDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"注册成功!" toView:SXKeyWindow];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)changeConfirmBtnEnabled{
    self.registBtn.enabled = self.phoneTextField.text.trim.length && self.codeTextField.text.trim.length;
}

@end
