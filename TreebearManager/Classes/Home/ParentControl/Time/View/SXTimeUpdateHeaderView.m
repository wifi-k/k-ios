//
//  SXTimeUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeUpdateHeaderView.h"
#import "UILabel+Extension.h"

@interface SXTimeUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *schemeL;
@property (weak, nonatomic) IBOutlet UIButton *updateNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *allowTimeL;
@property (weak, nonatomic) IBOutlet UILabel *timeContentL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *controlMobileL;
@property (weak, nonatomic) IBOutlet UILabel *deviceContentL;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;
@end

@implementation SXTimeUpdateHeaderView

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
    
    self.contentL.textColor = SXColor7383A2;
    self.schemeL.textColor = SXColor2B3852;
    self.allowTimeL.textColor = SXColor2B3852;
    self.controlMobileL.textColor = SXColor2B3852;
    
    [self.contentL setText:@"先选择控制的时间，然后选择控制的设备，则该设备只有在允许上网的时间才能访问网络" lineSpacing:8.0f];
    
    self.firstBgView.backgroundColor = [UIColor whiteColor];
    self.firstBgView.layer.cornerRadius = 5;
    self.firstBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.firstBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.firstBgView.layer.shadowOpacity = 0.5;
    self.firstBgView.layer.shadowRadius = 3;
    
    self.secondBgView.backgroundColor = [UIColor whiteColor];
    self.secondBgView.layer.cornerRadius = 5;
    self.secondBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.secondBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.secondBgView.layer.shadowOpacity = 0.5;
    self.secondBgView.layer.shadowRadius = 5;
    
    self.thirdBgView.backgroundColor = [UIColor whiteColor];
    self.thirdBgView.layer.cornerRadius = 5;
    self.thirdBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.thirdBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.thirdBgView.layer.shadowOpacity = 0.5;
    self.thirdBgView.layer.shadowRadius = 3;
    
    [self.updateNameBtn setTitleColor:SXColorSystemBlue forState:UIControlStateNormal];
    [self.updateNameBtn roundViewWithRadius:15.0f borderColor:SXColorSystemBlue borderWidth:1.0f];
    
    //添加事件
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTimeControlAppControl:)];
    [self.secondBgView addGestureRecognizer:tap2];
    
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDeviceControl:)];
    [self.thirdBgView addGestureRecognizer:tap3];
    
    //默认赋空值
    self.timeContentL.text = @"";
    self.deviceContentL.text = @"";
}

#pragma mark -setter方法-
- (void)setModel:(SXTimeControlModel *)model{
    _model = model;
    
    self.schemeL.text = model.name;
    
    if ([NSString isNotEmpty:model.st] && [NSString isNotEmpty:model.et]) {
        [self selectTime];
    }
    
    if (model.mac.count) {
        [self selectDevice];
    }
}

- (void)setUpData{
    self.schemeL.text = self.model.name;
}

- (void)selectTime{
    self.timeContentL.text = @"已设置";
}

- (void)selectDevice{
    self.deviceContentL.text = @"已设置";
}

- (BOOL)isSelectedAll{
    return [NSString isNotEmpty:self.timeContentL.text] && [NSString isNotEmpty:self.deviceContentL.text];
}

#pragma mark -点击事件-
- (IBAction)updateNameBtn:(UIButton *)sender {
    if (self.clickUpdateNameBtnBlock) {
        self.clickUpdateNameBtnBlock();
    }
}

- (void)clickTimeControlAppControl:(UITapGestureRecognizer *)sender {
    if (self.clickTimeControlAppBlock) {
        self.clickTimeControlAppBlock();
    }
}

- (void)clickDeviceControl:(UITapGestureRecognizer *)sender {
    if (self.clickDeviceControlBlock) {
        self.clickDeviceControlBlock();
    }
}

@end
