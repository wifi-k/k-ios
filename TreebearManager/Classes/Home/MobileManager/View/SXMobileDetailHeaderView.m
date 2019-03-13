//
//  SXMobileDetailHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileDetailHeaderView.h"

@interface SXMobileDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *topBgView;


@property (weak, nonatomic) IBOutlet UIView *centerFirstBgView;

@property (weak, nonatomic) IBOutlet UIView *centerSecondBgView;

@property (weak, nonatomic) IBOutlet UIView *centerThirdBgView;

@property (weak, nonatomic) IBOutlet UIView *centerFourthBgView;
@property (weak, nonatomic) IBOutlet UIView *centerBgView;

@property (weak, nonatomic) IBOutlet UIView *bottomFirstBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomSecondBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomThirdBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXMobileDetailHeaderView

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
    
    self.topBgView.backgroundColor = SXColorWhite;
    
    self.centerBgView.backgroundColor = [UIColor whiteColor];
    self.centerBgView.layer.cornerRadius = 5;
    self.centerBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.centerBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.centerBgView.layer.shadowOpacity = 0.5;
    self.centerBgView.layer.shadowRadius = 5;
    
    //1.1添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCenterFirstBgView)];
    [self.centerFirstBgView addGestureRecognizer:tap];
    
    self.bottomBgView.backgroundColor = [UIColor whiteColor];
    self.bottomBgView.layer.cornerRadius = 5;
    self.bottomBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.bottomBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.bottomBgView.layer.shadowOpacity = 0.5;
    self.bottomBgView.layer.shadowRadius = 5;
}

#pragma mark -点击事件-
- (void)clickCenterFirstBgView{
    if (self.clickCenterFirstBgViewBlock) {
        self.clickCenterFirstBgViewBlock();
    }
}

@end
