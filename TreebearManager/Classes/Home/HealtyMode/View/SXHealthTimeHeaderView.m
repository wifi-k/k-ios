//
//  SXHealthTimeHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealthTimeHeaderView.h"

@interface SXHealthTimeHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *beginTimeL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *endTimeL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXHealthTimeHeaderView

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
    
    [self.confirmBtn roundViewWithRadius:6.0f];
    
    //添加事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBeginTimeControl:)];
    [self.firstBgView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEndTimeControl:)];
    [self.secondBgView addGestureRecognizer:tap2];
    
    //默认值
    self.startTimeStr = @"00:00";
    self.endTimeStr = @"00:00";
}

#pragma mark -setter-
- (void)setModel:(SXHealtyControlTimeModel *)model{
    _model = model;
    
    self.beginTimeL.text = model.startTime;
    self.endTimeL.text = model.endTime;
}

#pragma mark -setter-
- (void)setStartTimeStr:(NSString *)startTimeStr{
    _startTimeStr = startTimeStr;
    
    self.beginTimeL.text = startTimeStr;
    self.model.startTime = startTimeStr;
}

- (void)setEndTimeStr:(NSString *)endTimeStr{
    _endTimeStr = endTimeStr;
    
    self.endTimeL.text = endTimeStr;
    self.model.endTime = endTimeStr;
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock(self.model);
    }
}

- (void)clickBeginTimeControl:(UITapGestureRecognizer *)sender {
    if (self.clickBeginTimeControlBlock) {
        self.clickBeginTimeControlBlock();
    }
}

- (void)clickEndTimeControl:(UITapGestureRecognizer *)sender {
    if (self.clickEndTimeControlBlock) {
        self.clickEndTimeControlBlock();
    }
}

@end
