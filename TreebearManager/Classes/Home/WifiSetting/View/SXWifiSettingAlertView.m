//
//  SXWifiSettingAlertView.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingAlertView.h"

const CGFloat SXWifiSettingAlertViewWidthRatio = 0.655;  //宽度系数
const CGFloat SXWifiSettingAlertViewHeightRatio = 0.216; //高度系统

@interface SXWifiSettingAlertView ()

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UILabel *titleL;//标题
@property (nonatomic, weak) UITextField *textField;//文本输入框
@property (nonatomic, weak) UIView *bottomView;//底部视图
@property (nonatomic, weak) UIButton *confirmButton;//确认按钮
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮

@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *placeholder;//占位符
@property (nonatomic, copy) NSString *confirmStr;//确认按钮
@property (nonatomic, copy) NSString *cancelStr;//取消按钮
@end

@implementation SXWifiSettingAlertView

+ (instancetype)alertWithTitle:(NSString *)title placeholder:(NSString *)placeholder confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr{
    SXWifiSettingAlertView *alert = [[self alloc] initWithFrame:UIApplication.sharedApplication.delegate.window.bounds];
    alert.title = title;
    alert.placeholder = placeholder;
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
    self.titleL = titleL;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = SXColorGray7;
    textField.placeholder = @"请输入...";
    [self.bgImageView addSubview:textField];
    self.textField = textField;
    [self.textField roundViewWithRadius:4];
    UIImageView *leftImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 24)];
    leftImageV.contentMode = UIViewContentModeCenter;
    self.textField.leftView = leftImageV;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    //底部视图
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.bgImageView addSubview:bottomView];
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
    //    CGFloat contentW = [UIScreen mainScreen].bounds.size.width * SXWifiSettingAlertViewWidthRatio;
    //    CGFloat contentH = [UIScreen mainScreen].bounds.size.height * SXWifiSettingAlertViewHeightRatio;
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 30 * 2;
    CGFloat contentH = 200;
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(contentW, contentH));
        make.center.mas_equalTo(self);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageView.mas_top).mas_offset(30);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.bgImageView).mas_offset(20);
        make.right.mas_equalTo(self.bgImageView.mas_right).mas_offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView);
        make.bottom.mas_equalTo(self.bgImageView.mas_bottom);
        make.right.mas_equalTo(self.bgImageView);
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
    NSString *input = self.textField.text.filterSpace;
    if ([NSString isEmpty:input]) {
        [MBProgressHUD showMessageToWindow:self.placeholder];
        return;
    }
    
    if (self.confirmButtonBlock) {
        self.confirmButtonBlock(input);
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
    self.titleL.text = title;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
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
