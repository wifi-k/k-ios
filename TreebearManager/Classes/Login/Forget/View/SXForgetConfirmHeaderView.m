//
//  SXForgetConfirmHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetConfirmHeaderView.h"

@interface SXForgetConfirmHeaderView ()
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
    
@property (weak, nonatomic) IBOutlet UITextField *pwd2TextFeild;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
    
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *licence;
@end

@implementation SXForgetConfirmHeaderView

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
- (IBAction)clickVisibleBtn1:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickVisibleBtn2:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwd2TextFeild.secureTextEntry = !sender.isSelected;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
