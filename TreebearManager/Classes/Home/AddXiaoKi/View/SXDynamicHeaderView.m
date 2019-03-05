//
//  SXDynamicHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDynamicHeaderView.h"

@interface SXDynamicHeaderView ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXDynamicHeaderView

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

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.firstLineView.backgroundColor = SXColorDivideLine;
    self.secondLineView.backgroundColor = SXColorDivideLine;
    
    self.firstLineView.height = 0.5;
    self.secondLineView.height = 0.5;
    
    [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.confirmBtn roundViewWithRadius:6.0f];
    
    self.confirmBtn.enabled = NO;
    
    //成为第一响应
    [self.nameTextField becomeFirstResponder];
}

#pragma mark -点击事件-
- (IBAction)clickVisibleBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.pwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingNameTextField:(UITextField *)sender {
    DLog(@"editingNameTextField:%@",sender.text);
    self.firstLineView.backgroundColor = SXColorBlue;
    self.firstLineView.height = 1;
    //    self.param.passwd = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endNameTextField:(UITextField *)sender {
    DLog(@"endNameTextField:%@",sender.text);
    self.firstLineView.backgroundColor = UIColor.lightGrayColor;
    self.firstLineView.height = 0.5;
}

- (IBAction)editingPwdTextField:(UITextField *)sender {
    DLog(@"editingPwdTextField:%@",sender.text);
    self.secondLineView.backgroundColor = SXColorBlue;
    self.secondLineView.height = 1;
    //    self.param.passwd2 = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endPwdTextField:(UITextField *)sender {
    DLog(@"endPwdTextField:%@",sender.text);
    self.secondLineView.backgroundColor = UIColor.lightGrayColor;
    self.secondLineView.height = 0.5;
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.nameTextField.text.trim.length && self.pwdTextField.text.trim.length;
}

@end
