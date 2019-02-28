//
//  SXDatePickerView.m
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDatePickerView.h"

@interface SXDatePickerView ()
@property (nonatomic, weak) UIView *bgView;//背景视图
@property (nonatomic, weak) UIView *contentBgView;//内容背景视图
@property (nonatomic, weak) UIDatePicker *datePicker;//日期组件视图
@property (nonatomic, weak) UIView *topBgView;//头部背景视图
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮
@property (nonatomic, weak) UIButton *confirmButton;//确定按钮
@property (nonatomic, weak) UILabel *titleL;//标题

@property (nonatomic, copy) NSString *dateStr;//记录选中日期
@end

@implementation SXDatePickerView

+ (instancetype)pickerView{
    return [[self alloc] initWithFrame:SXKeyWindow.bounds];
}

- (void)showPickerView{
    
    [SXDelegateWindow addSubview:self];
    
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT-250, SCREEN_WIDTH, 250);
    }];
}

- (void)hidePickerView{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    } completion:^(BOOL finished) {
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self removeFromSuperview];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    //1.半透明遮盖视图（满屏）
    UIView *bgView = [[UIView alloc] initWithFrame:SXKeyWindow.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    //1.1添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView)];
    [self.bgView addGestureRecognizer:tap];
    
    //2.内容背景视图
    UIView *contentBgView = [[UIView alloc] init];
    contentBgView.backgroundColor = UIColor.whiteColor;
    [self addSubview:contentBgView];
    self.contentBgView = contentBgView;
    
    //3.背景图片视图
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColorFromRGB(0xf5f5f5);
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    datePicker.timeZone = [NSTimeZone localTimeZone];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentBgView addSubview:datePicker];
    self.datePicker = datePicker;
    
    //4.添加头部视图
    UIView *topBgView = [[UIView alloc] init];
    topBgView.backgroundColor = UIColor.whiteColor;
    [self.contentBgView addSubview:topBgView];
    self.topBgView = topBgView;
    
    //5.取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:UIColorFromRGB(0xed5565) forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancleButton setBackgroundColor:[UIColor clearColor]];
    [cancleButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton addTarget:self action:@selector(cancleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.topBgView addSubview:cancleButton];
    self.cancleButton = cancleButton;
    
    //6.完成按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:SXColorBlue forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmButton setBackgroundColor:[UIColor whiteColor]];
    [confirmButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.topBgView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    
    //7.选择日期
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = SXColor333333;
    titleL.text = @"选择日期";
    [self.topBgView addSubview:titleL];
    self.titleL = titleL;
    
    //给出开一个默认显示日期
    NSDate *theDate = NSDate.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH时mm分";
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    NSString *dateStr = [dateFormatter stringFromDate:theDate];
    self.dateStr = dateStr;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(250);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(210);
    }];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.datePicker.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topBgView).mas_offset(0);
        make.centerY.mas_equalTo(self.topBgView);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topBgView.mas_right).mas_offset(0);
        make.centerY.mas_equalTo(self.topBgView);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.topBgView);
    }];
}

#pragma mark -点击事件-
//点击遮罩
- (void)clickBgView{
    if(!self.closeUserInteractionEnabled) [self cancleButtonTapped];
}

- (void)cancleButtonTapped{
    [self hidePickerView];
//    [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.1];
}

#pragma mark -点击完成按钮-
- (void)confirmButtonTapped{
    if (self.confirmButtonBlock) {
        self.confirmButtonBlock(self.dateStr);
    }
    if (self.dateStr) {
        [self cancleButtonTapped];
    }
}

#pragma mark -日期改变监听方法-
- (void)dateChange:(UIDatePicker *)datePicker{
    NSDate *theDate = datePicker.date;
    DLog(@"%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSString *dateStr = [dateFormatter stringFromDate:theDate];
    self.dateStr = dateStr;
    DLog(@"%@",dateStr);
}

@end
