//
//  SXLoginHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginHeaderView.h"

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
    
@end
