//
//  SXUpdatePwdConfirmController.m
//  TreebearManager
//
//  Created by bear on 2019/3/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUpdatePwdConfirmController.h"
#import "SXLoginNetTool.h"
#import "SXRegistParam.h"
#import "NSString+Hash.h"

@interface SXUpdatePwdConfirmController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *visibleBtn1;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UITextField *pwd2TextField;
@property (weak, nonatomic) IBOutlet UIButton *visibleBtn2;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
///模型
@property (nonatomic, strong) SXRegistParam *param;
@end

@implementation SXUpdatePwdConfirmController

#pragma mark -getter-
- (SXRegistParam *)param{
    if (_param == nil) {
        _param = [[SXRegistParam alloc] init];
    }
    return _param;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self setUpUI];
}

#pragma mark -UI-
- (void)setUpUI{
    
    self.navigationItem.title = @"修改密码";
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView.height = 0.5;
    self.bottomLineView2.height = 0.5;
    
    [self.confirmBtn roundViewWithRadius:6.0f];
    self.confirmBtn.enabled = NO;
}

#pragma mark -Event-
- (IBAction)clickVisibleBtn1:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickVisibleBtn2:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwd2TextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (![self.param.passwd isEqualToString:self.param.passwd2]) {
        [MBProgressHUD showWarningWithMessage:@"两次密码输入不一致，请重试!" toView:SXKeyWindow];
        return;
    }
    
    [self resetPasswordData];
}

- (IBAction)editingPwdTextField:(UITextField *)sender {
    DLog(@"editingPwdTextField:%@",sender.text);
    self.param.passwd = sender.text.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)editingPwd2TextField:(UITextField *)sender {
    DLog(@"editingPwd2TextField:%@",sender.text);
    self.param.passwd2 = sender.text.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.pwdTextField.text.filterSpace.length && self.pwd2TextField.text.filterSpace.length;
}

#pragma mark -修改密码设置接口-
- (void)resetPasswordData{
    WS(weakSelf);
    SXRegistParam *param = [SXRegistParam param];
    param.passwd = self.param.passwd.md5String;
    [SXLoginNetTool setPasswdDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
