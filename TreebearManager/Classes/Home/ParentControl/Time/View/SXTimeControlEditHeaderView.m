//
//  SXTimeControlEditHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlEditHeaderView.h"

@interface SXTimeControlEditHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *beginTimeL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *endTimeL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *weekBgView;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXTimeControlEditHeaderView

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
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 40;
    CGFloat btnH = 40;
    for (int i=0; i<7; i++) {
        btnX = i * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = SXColorRandom;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        NSString *title = [NSString stringWithFormat:@"%d",i];
        [btn setTitle:title forState:UIControlStateNormal];
        [self.weekBgView addSubview:btn];
    }
    
    //默认值
    self.endTimeStr = @"";
    self.beginTimeStr = @"";
}

#pragma mark -setter-
- (void)setBeginTimeStr:(NSString *)beginTimeStr{
    _beginTimeStr = beginTimeStr;
    
    self.beginTimeL.text = beginTimeStr;
}

- (void)setEndTimeStr:(NSString *)endTimeStr{
    _endTimeStr = endTimeStr;
    
    self.endTimeL.text = endTimeStr;
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
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
