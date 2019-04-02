//
//  SXTimeUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeUpdateHeaderView.h"

@interface SXTimeUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *schemeL;
@property (weak, nonatomic) IBOutlet UIButton *updateNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *timeContentL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

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
    
    self.backgroundColor = SXColorBgViewGray;
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    
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
}

- (void)setUpData{
    self.schemeL.text = self.model.name;
}

- (void)selectTime{
    self.timeContentL.text = @"已选择";
}

- (void)selectDevice{
    self.deviceContentL.text = @"已选择";
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
