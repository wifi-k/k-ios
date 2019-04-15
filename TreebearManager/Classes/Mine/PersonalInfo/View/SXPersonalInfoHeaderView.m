//
//  SXPersonalInfoHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPersonalInfoHeaderView.h"

@interface SXPersonalInfoHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *avatarTitleL;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *nickTitleL;
@property (weak, nonatomic) IBOutlet UILabel *nickL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *mobileTitleL;
@property (weak, nonatomic) IBOutlet UILabel *mobileL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView3;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *pwdTitleL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView4;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;
@end

@implementation SXPersonalInfoHeaderView

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

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;

    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    
    self.avatarTitleL.textColor = SXColor2B3852;
    self.nickTitleL.textColor = SXColor2B3852;
    self.mobileTitleL.textColor = SXColor2B3852;
    self.pwdTitleL.textColor = SXColor2B3852;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    self.bottomLineView3.backgroundColor = SXColorDivideLine;
    self.bottomLineView4.backgroundColor = SXColorDivideLine;
    self.bottomLineView1.height = 0.5f;
    self.bottomLineView2.height = 0.5f;
    self.bottomLineView3.height = 0.5f;
    self.bottomLineView4.height = 0.5f;
    
    self.mobileL.textColor = SXColor7383A2;
    self.nickL.textColor = SXColor7383A2;
    
    [self.iconImageView roundViewWithRadius:22.5f];
    
    //添加事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIconBgView)];
    [self.firstBgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNickNameBgView)];
    [self.secondBgView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMobileBgView)];
    [self.thirdBgView addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPasswordBgView)];
    [self.fourthBgView addGestureRecognizer:tap4];
}

#pragma mark -setter-
- (void)setUpData{
    SXMineUserInfoModel *userInfo = SXPersonInfoModel.sharedSXPersonInfoModel.result.user;
    NSString *nameStr = @"";
    if ([NSString isNotEmpty:userInfo.mobile] && userInfo.mobile.length > 4) {
        NSRange range = NSMakeRange(userInfo.mobile.length-4, 4);
        NSString *subMobile = [userInfo.mobile substringWithRange:range];
        nameStr = [NSString isEmpty:userInfo.name] ? [NSString stringWithFormat:@"用户%@",subMobile] : userInfo.name;
    }
    self.nickL.text = nameStr;
    self.mobileL.text = userInfo.mobile;
    NSString *avatar = userInfo.avatar;
    NSURL *avatarUrl = [NSURL URLWithString:avatar];
    [self.iconImageView sd_setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"mine_xioaki_default2"] options:SDWebImageRetryFailed];
}

#pragma mark -Event-
- (void)clickIconBgView{
    if (self.clickIconBgViewBlock) {
        self.clickIconBgViewBlock();
    }
}

- (void)clickNickNameBgView{
    if (self.clickNickNameBgViewBlock) {
        self.clickNickNameBgViewBlock();
    }
}

- (void)clickMobileBgView{
    if (self.clickMobileBgViewBlock) {
        self.clickMobileBgViewBlock();
    }
}

- (void)clickPasswordBgView{
    if (self.clickPasswordBgViewBlock) {
        self.clickPasswordBgViewBlock();
    }
}

@end
