//
//  SXLANPortHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLANPortHeaderView.h"

@interface SXLANPortHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *macTitleL;
@property (weak, nonatomic) IBOutlet UITextField *macTextField;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *dnsTitleL;
@property (weak, nonatomic) IBOutlet UITextField *dnsTextField;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *ipTitleL;
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UIView *thirdLineView;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *maskTitleL;
@property (weak, nonatomic) IBOutlet UITextField *maskTextField;
@property (weak, nonatomic) IBOutlet UIView *fourthLineView;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@end

@implementation SXLANPortHeaderView

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
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    
    self.macTitleL.textColor = SXColor7383A2;
    self.dnsTitleL.textColor = SXColor7383A2;
    self.ipTitleL.textColor = SXColor7383A2;
    self.maskTitleL.textColor = SXColor7383A2;
    
    self.macTextField.backgroundColor = SXColorF6F7FB;
    self.dnsTextField.backgroundColor = SXColorF6F7FB;
    self.ipTextField.backgroundColor = SXColorF6F7FB;
    self.maskTextField.backgroundColor = SXColorF6F7FB;
    
    //1.填补视图
    UIImageView *leftImageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV1.contentMode = UIViewContentModeCenter;
    self.macTextField.leftView = leftImageV1;
    self.macTextField.leftViewMode = UITextFieldViewModeAlways;
    //2.填补视图
    UIImageView *leftImageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV2.contentMode = UIViewContentModeCenter;
    self.dnsTextField.leftView = leftImageV2;
    self.dnsTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //3.填补视图
    UIImageView *leftImageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV3.contentMode = UIViewContentModeCenter;
    self.ipTextField.leftView = leftImageV3;
    self.ipTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //4.填补视图
    UIImageView *leftImageV4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV4.contentMode = UIViewContentModeCenter;
    self.maskTextField.leftView = leftImageV4;
    self.maskTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.firstLineView.backgroundColor = SXColorDivideLine;
    self.secondLineView.backgroundColor = SXColorDivideLine;
    self.thirdLineView.backgroundColor = SXColorDivideLine;
    self.fourthLineView.backgroundColor = SXColorDivideLine;
    
    self.firstLineView.height = 0.1;
    self.secondLineView.height = 0.1;
    self.thirdLineView.height = 0.1;
    self.fourthLineView.height = 0.1;
    
    self.firstLineView.hidden = YES;
    self.secondLineView.hidden = YES;
    self.thirdLineView.hidden = YES;
    self.fourthLineView.hidden = YES;
    
    [self.saveBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg"] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateDisabled];
    [self.saveBtn roundViewWithRadius:6.0f];
    
    [self.macTextField becomeFirstResponder];
    
    [self.macTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.dnsTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.ipTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    [self.maskTextField setValue:SXColorB6C0CB forKeyPath:@"_placeholderLabel.textColor"];
    
    self.macTextField.tintColor = SXColorBlue2;
    self.dnsTextField.tintColor = SXColorBlue2;
    self.ipTextField.tintColor = SXColorBlue2;
    self.maskTextField.tintColor = SXColorBlue2;
}

#pragma mark -点击保存-
- (IBAction)clickSaveBtn:(UIButton *)sender {
    if (self.clickSaveBtnBlock) {
        self.clickSaveBtnBlock();
    }
}

@end
