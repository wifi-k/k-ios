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
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *mobileTitleL;
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
    
    self.avatarTitleL.textColor = SXColor333333;
    self.nickTitleL.textColor = SXColor333333;
    self.mobileTitleL.textColor = SXColor333333;
    self.pwdTitleL.textColor = SXColor333333;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    self.bottomLineView3.backgroundColor = SXColorDivideLine;
    self.bottomLineView4.backgroundColor = SXColorDivideLine;
    self.bottomLineView1.height = 0.5f;
    self.bottomLineView2.height = 0.5f;
    self.bottomLineView3.height = 0.5f;
    self.bottomLineView4.height = 0.5f;
    
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
//- (void)setImage:(UIImage *)image{
//    _image = image;
//
//    self.iconImageView.image = image;
//}

- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_user_icon"] options:SDWebImageRetryFailed];
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
