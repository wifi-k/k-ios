//
//  SXNetBroadbandHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetBroadbandHeaderView.h"

@interface SXNetBroadbandHeaderView ()
@property (weak, nonatomic) IBOutlet UITextField *broadAccountTextField;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;

@property (weak, nonatomic) IBOutlet UITextField *broadPwdTextField;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXNetBroadbandHeaderView

#pragma mark -getter-
- (SXNetBroadbandParam *)param{
    if (_param == nil) {
        _param = [[SXNetBroadbandParam alloc] init];
    }
    return _param;
}

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
    [self.broadAccountTextField becomeFirstResponder];
}

#pragma mark -按钮点击事件-
- (IBAction)clickVisibleBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.broadPwdTextField.secureTextEntry = !sender.isSelected;
}

- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

#pragma mark -文本输入框编辑-
- (IBAction)editingBroadAccoutTextField:(UITextField *)sender {
    DLog(@"editingBroadAccoutTextField:%@",sender.text);
    self.firstLineView.backgroundColor = SXColorBlue;
    self.firstLineView.height = 1;
    self.param.name = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endBroadAccoutTextField:(UITextField *)sender {
    DLog(@"endBroadAccoutTextField:%@",sender.text);
    self.firstLineView.backgroundColor = UIColor.lightGrayColor;
    self.firstLineView.height = 0.5;
}

- (IBAction)editingBroadPwdTextField:(UITextField *)sender {
    DLog(@"editingBroadPwdTextField:%@",sender.text);
    self.secondLineView.backgroundColor = SXColorBlue;
    self.secondLineView.height = 1;
    self.param.passwd = sender.text.trim.filterSpace;
    [self changeConfirmBtnEnabled];
}

- (IBAction)endBroadPwdTextField:(UITextField *)sender {
    DLog(@"endBroadPwdTextField:%@",sender.text);
    self.secondLineView.backgroundColor = UIColor.lightGrayColor;
    self.secondLineView.height = 0.5;
}

- (void)changeConfirmBtnEnabled{
    self.confirmBtn.enabled = self.broadAccountTextField.text.trim.length && self.broadPwdTextField.text.trim.length;
}

@end
