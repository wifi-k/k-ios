//
//  SXCodeInputAlertView.m
//  TreebearManager
//
//  Created by bear on 2019/2/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXCodeInputAlertView.h"

const CGFloat SXCodeInputAlertViewWidthRatio = 0.655;  //宽度系数
const CGFloat SXCodeInputAlertViewHeightRatio = 0.216; //高度系统

@interface SXCodeInputAlertView ()
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UILabel *titleLabel;//标题
@property (nonatomic, weak) UITextField *textField;//文本输入框
@property (nonatomic, weak) UIButton *confirmButton;//确认按钮
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮

@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *confirmStr;//确认按钮
@property (nonatomic, copy) NSString *cancelStr;//取消按钮
@end

@implementation SXCodeInputAlertView

+ (instancetype)alertWithTitle:(NSString *)title confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr{
    SXCodeInputAlertView *alert = [[self alloc] initWithFrame:UIApplication.sharedApplication.delegate.window.bounds];
    alert.title = title;
    alert.confirmStr = confirmStr;
    alert.cancelStr = cancelStr;
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
    [bgImageView roundViewWithRadius:10];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    //标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.numberOfLines = 2;
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.font = SXFont18;
    titleL.textColor = [UIColor blackColor];
    [self.bgImageView addSubview:titleL];
    self.titleLabel = titleL;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = SXColorGray7;
    textField.placeholder = @"请输入家庭码";
    [self.bgImageView addSubview:textField];
    self.textField = textField;
    [self.textField roundViewWithRadius:4];
    
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV.contentMode = UIViewContentModeCenter;
    self.textField.leftView = leftImageV;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    //确定按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmButton setBackgroundColor:[UIColor greenColor]];
    [confirmButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    [self.confirmButton roundViewWithRadius:4];
    
    //取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancleButton setBackgroundColor:[UIColor greenColor]];
    [cancleButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton addTarget:self action:@selector(cancleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:cancleButton];
    self.cancleButton = cancleButton;
    [self.cancleButton roundViewWithRadius:4];
    
    self.bgView.alpha = 1;
    
    self.closeUserInteractionEnabled = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //内容宽高
//    CGFloat contentW = [UIScreen mainScreen].bounds.size.width * SXCodeInputAlertViewWidthRatio;
//    CGFloat contentH = [UIScreen mainScreen].bounds.size.height * SXCodeInputAlertViewHeightRatio;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 30 * 2;
    CGFloat contentH = 200;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
        make.center.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageView.mas_top).mas_offset(30);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(contentW/2 - 25, 40));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(-20);
        make.size.mas_equalTo(CGSizeMake(contentW/2 - 25, 40));
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
    if (self.cancelButtonBlock) {
        self.cancelButtonBlock();
    }
    
    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.12];
}

- (void)removeSelf{
    [self removeFromSuperview];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
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
