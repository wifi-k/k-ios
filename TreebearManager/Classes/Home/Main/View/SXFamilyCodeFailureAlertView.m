//
//  SXFamilyCodeFailureAlertView.m
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyCodeFailureAlertView.h"

const CGFloat SXFamilyCodeFailureAlertViewWidthRatio = 0.655;  //宽度系数
const CGFloat SXFamilyCodeFailureAlertViewHeightRatio = 0.206; //高度系统

@interface SXFamilyCodeFailureAlertView ()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *topImageView;//头部ImagView
@property (nonatomic, weak) UILabel *titleL;//标题
@property (nonatomic, weak) UILabel *contentL;//内容
@property (nonatomic, weak) UIView *bottomView;//底部视图
@property (nonatomic, weak) UIButton *confirmButton;//确认按钮

@property (nonatomic, copy) NSString *topImageName;//头部ImageName
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *confirmStr;//确认按钮
@end

@implementation SXFamilyCodeFailureAlertView

+ (instancetype)alertWithTopImageName:(NSString *)imageName title:(NSString *)title content:(NSString *)content confirmStr:(NSString *)confirmStr{
    SXFamilyCodeFailureAlertView *alert = [[self alloc] initWithFrame:UIApplication.sharedApplication.delegate.window.bounds];
    alert.topImageName = imageName;
    alert.title = title;
    alert.content = content;
    alert.confirmStr = confirmStr;
    return alert;
}

- (void)alert{
    [UIApplication.sharedApplication.delegate.window addSubview:self];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    //半透明遮盖视图（满屏）
    UIView *bgView = [[UIView alloc] initWithFrame:UIApplication.sharedApplication.delegate.window.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    bgView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapped)];
    [bgView addGestureRecognizer:tap];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    //背景图片视图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [bgImageView setUserInteractionEnabled:YES];
    [bgImageView roundViewWithRadius:6];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    //头部视图ImageView
    UIImageView *topImageView = [[UIImageView alloc] init];
    [self.bgImageView addSubview:topImageView];
    self.topImageView = topImageView;
    
    //标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.numberOfLines = 2;
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = SXFontBold18;
    titleL.textColor = [UIColor blackColor];
    [self.bgImageView addSubview:titleL];
    self.titleL = titleL;
    
    //内容
    UILabel *contentL = [[UILabel alloc] init];
    contentL.numberOfLines = 2;
    contentL.textAlignment = NSTextAlignmentCenter;
    contentL.font = SXFont16;
    contentL.textColor = [UIColor grayColor];
    [self.bgImageView addSubview:contentL];
    self.contentL = contentL;
    
    //底部视图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.bgImageView addSubview:bottomView];
    self.bottomView = bottomView;
    
    //确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmButton setBackgroundColor:SXColorBlue];
    [confirmButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:SXFontBold16];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    self.bgView.alpha = 1;
    
    self.closeUserInteractionEnabled = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //内容宽高
    //    CGFloat contentW = [UIScreen mainScreen].bounds.size.width * SXFamilyCodeFailureAlertViewWidthRatio;
    //    CGFloat contentH = [UIScreen mainScreen].bounds.size.height * SXFamilyCodeFailureAlertViewHeightRatio;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 30 * 2;
    CGFloat contentH = 260;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
        make.center.mas_equalTo(self);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_equalTo(self.bgImageView.mas_top).mas_offset(30);
        make.centerX.mas_equalTo(self.bgImageView);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom);
        make.right.mas_equalTo(self.bgImageView);
        make.height.mas_equalTo(45);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView);
        make.right.mas_equalTo(self.bottomView.mas_right);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom);
        make.height.mas_equalTo(45);
    }];
}

#pragma mark -按钮点击事件-
- (void)confirmButtonTapped{
    if (self.confirmButtonBlock) {
        self.confirmButtonBlock();
    }
    
    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.12];
}

//点击遮罩
- (void)bgViewTapped{
    if(!self.closeUserInteractionEnabled) [self cancleButtonTapped];
}

- (void)cancleButtonTapped{
    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.12];
}

- (void)removeSelf{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setTopImageName:(NSString *)topImageName{
    _topImageName = topImageName;
    
    self.topImageView.image = [UIImage imageNamed:topImageName];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleL.text = title;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.contentL.text = content;
}

- (void)setConfirmStr:(NSString *)confirmStr{
    _confirmStr = confirmStr;
    if (confirmStr) {
        [self.confirmButton setTitle:confirmStr forState:UIControlStateNormal];
    }
}

@end
