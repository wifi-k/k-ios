//
//  SXCodeLoginHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXCodeLoginHeaderView.h"
#import "SXLoginCertifyCodeButton.h"
#import "SXLoginNetTool.h"

@interface SXCodeLoginHeaderView ()
@property (weak, nonatomic) IBOutlet SXLoginCertifyCodeButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV2;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end


@implementation SXCodeLoginHeaderView

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
    
}

#pragma mark -按钮点击事件-
- (IBAction)clickCodeBtn:(SXLoginCertifyCodeButton *)sender {
    [sender start];
    
    NSString *mobile = self.phoneTextField.text.filterSpace;
    [SXLoginNetTool getCodeDataWithMobile:mobile Success:^{
        DLog(@"成功");
    } failure:^(NSError * _Nonnull error) {
        DLog(@"失败");
    }];
}

- (IBAction)clickLoginBtnBlock:(UIButton *)sender {
    if (self.clickLoginBtnBlock) {
        self.clickLoginBtnBlock();
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
    self.param.code = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endCodeTextField:(UITextField *)sender {
    DLog(@"endCodeTextField:%@",sender.text);
    self.bottomLineV2.backgroundColor = UIColor.lightGrayColor;
}

- (void)changeConfirmBtnEnabled{
    self.loginBtn.enabled = self.phoneTextField.text.trim.length && self.codeTextField.text.trim.length;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end

