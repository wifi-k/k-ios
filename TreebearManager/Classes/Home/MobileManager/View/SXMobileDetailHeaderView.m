//
//  SXMobileDetailHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileDetailHeaderView.h"

@interface SXMobileDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *naviTitleL;
@property (weak, nonatomic) IBOutlet UIImageView *topIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UILabel *mobileInfoTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerFirstBgView;

@property (weak, nonatomic) IBOutlet UISwitch *careSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *childCareTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerSecondBgView;

@property (weak, nonatomic) IBOutlet UISwitch *remindSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *remindTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerThirdBgView;

@property (weak, nonatomic) IBOutlet UISwitch *blackSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *blacklistTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerFourthBgView;
@property (weak, nonatomic) IBOutlet UIView *centerBgView;

@property (weak, nonatomic) IBOutlet UISwitch *limitSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *limitTitleL;
@property (weak, nonatomic) IBOutlet UIView *bottomFirstBgView;

@property (weak, nonatomic) IBOutlet UILabel *upTitleL;
@property (weak, nonatomic) IBOutlet UISlider *upSlider;
@property (weak, nonatomic) IBOutlet UILabel *upL;
@property (weak, nonatomic) IBOutlet UIView *bottomSecondBgView;

@property (weak, nonatomic) IBOutlet UILabel *downTitleL;
@property (weak, nonatomic) IBOutlet UISlider *downSlider;
@property (weak, nonatomic) IBOutlet UILabel *downL;
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
    
    self.naviTitleL.font = SXFontBold18;
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
    
    
    //缩放
    //    self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.careSwitchBtn.onTintColor = SXColorBlue2;
    self.remindSwitchBtn.onTintColor = SXColorBlue2;
    self.blackSwitchBtn.onTintColor = SXColorBlue2;
    self.limitSwitchBtn.onTintColor = SXColorBlue2;
    
    self.upSlider.tintColor = SXColorBlue2;
    self.downSlider.tintColor = SXColorBlue2;
}

#pragma mark -点击事件-
- (IBAction)clickBackBtn:(UIButton *)sender {
    if (self.clickBackBtnBlock) {
        self.clickBackBtnBlock();
    }
}

- (void)clickCenterFirstBgView{
    if (self.clickCenterFirstBgViewBlock) {
        self.clickCenterFirstBgViewBlock();
    }
}

- (IBAction)clickEditBtn:(UIButton *)sender {
    if (self.clickEditBtnBlock) {
        self.clickEditBtnBlock();
    }
}



@end
