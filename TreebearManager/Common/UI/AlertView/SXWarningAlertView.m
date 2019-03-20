//
//  SXWarningAlertView.m
//  TreebearManager
//
//  Created by bear on 2019/3/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWarningAlertView.h"

const CGFloat SXWarningAlertViewWidthRatio = 0.655;  //宽度系数
const CGFloat SXWarningAlertViewHeightRatio = 0.206; //高度系统

@interface SXWarningAlertView ()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *contentBgView;
@property (nonatomic, weak) UIImageView *topImageView;
@property (nonatomic, weak) UILabel *titleL;//标题
@property (nonatomic, weak) UILabel *contentL;//内容
@property (nonatomic, weak) UIView *bottomView;//底部视图
@property (nonatomic, weak) UIButton *confirmButton;//确认按钮
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮

@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *confirmStr;//确认按钮
@property (nonatomic, copy) NSString *cancelStr;//取消按钮
@end

@implementation SXWarningAlertView

+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr{
    SXWarningAlertView *alert = [[self alloc] initWithFrame:SXDelegateWindow.bounds];
    alert.title = title;
    alert.content = content;
    alert.confirmStr = confirmStr;
    alert.cancelStr = cancelStr;
    return alert;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)alert{
    [SXDelegateWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    //半透明遮盖视图（满屏）
    UIView *bgView = [[UIView alloc] initWithFrame:UIApplication.sharedApplication.delegate.window.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    bgView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapped)];
    [bgView addGestureRecognizer:tap];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    //背景图片视图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [bgImageView setUserInteractionEnabled:YES];
    [bgImageView roundViewWithRadius:10];
    [self addSubview:bgImageView];
    self.contentBgView = bgImageView;
    
    //头部icon
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"home_familycode_failure"];
    [self.contentBgView addSubview:topImageView];
    self.topImageView = topImageView;
    
    //标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = SXFontBold18;
    titleL.textColor = [UIColor blackColor];
    [self.contentBgView addSubview:titleL];
    self.titleL = titleL;
    
    //内容
    UILabel *contentL = [[UILabel alloc] init];
    contentL.numberOfLines = 2;
    contentL.textAlignment = NSTextAlignmentCenter;
    contentL.textColor = SXColor999999;
    contentL.font = SXFont14;
    [self.contentBgView addSubview:contentL];
    self.contentL = contentL;
    
    //底部视图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.contentBgView addSubview:bottomView];
    self.bottomView = bottomView;
    
    //确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"img_button_bg_small"] forState:UIControlStateNormal];
    //[confirmButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    //取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancleButton setBackgroundColor:SXColorGray7];
    //[cancleButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton addTarget:self action:@selector(cancleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:cancleButton];
    self.cancleButton = cancleButton;
    
    self.bgView.alpha = 1;
    
    self.closeUserInteractionEnabled = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //内容宽高
    //    CGFloat contentW = [UIScreen mainScreen].bounds.size.width * SXWarningAlertViewWidthRatio;
    //    CGFloat contentH = [UIScreen mainScreen].bounds.size.height * SXWarningAlertViewHeightRatio;
    
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 30 * 2;
    CGFloat contentH = 280;
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
        make.center.mas_equalTo(self);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_equalTo(self.contentBgView.mas_top).mas_offset(30);
        make.centerX.mas_equalTo(self.contentBgView);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.contentBgView).mas_offset(20);
        make.right.mas_equalTo(self.contentBgView.mas_right).mas_offset(-20);
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.contentBgView).mas_offset(20);
        make.right.mas_equalTo(self.contentBgView.mas_right).mas_offset(-20);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.bottom.mas_equalTo(self.contentBgView.mas_bottom);
        make.right.mas_equalTo(self.contentBgView);
        make.height.mas_equalTo(45);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(contentW/2 - 0.1, 45));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(contentW/2 - 0.1, 45));
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
        
        if (self.cancelButtonBlock) {
            self.cancelButtonBlock();
        }
        
        [self removeFromSuperview];
    }];
}

#pragma mark -setter-
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

- (void)setCancelStr:(NSString *)cancelStr{
    _cancelStr = cancelStr;
    if (cancelStr) {
        [self.cancleButton setTitle:cancelStr forState:UIControlStateNormal];
    }
}

@end