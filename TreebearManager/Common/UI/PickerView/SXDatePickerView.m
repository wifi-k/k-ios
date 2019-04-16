//
//  SXDatePickerView.m
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDatePickerView.h"

#define SXDatePickerViewHeight (315+iPhoneX_Add_Bottom)
#define SXDatePickerBottomHeight (65+iPhoneX_Add_Bottom)

@interface SXDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, weak) UIView *bgView;//背景视图
@property (nonatomic, weak) UIView *contentBgView;//内容背景视图
@property (nonatomic, weak) UIPickerView *datePicker;//日期组件视图
@property (nonatomic, weak) UIView *topBgView;//头部背景视图
@property (nonatomic, weak) UIView *bottomBgView;//底部背景视图
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮
@property (nonatomic, weak) UIButton *confirmButton;//确定按钮
@property (nonatomic, weak) UILabel *titleL;//标题

@property (nonatomic, copy) NSString *hourStr;//记录选中日期
@property (nonatomic, copy) NSString *minuteStr;//记录选中日期
@property (nonatomic, strong) NSMutableArray *hourArray;//时钟数组
@property (nonatomic, strong) NSMutableArray *minuteArray;//分钟数组
@end

@implementation SXDatePickerView

#pragma mark -getter-
- (NSMutableArray *)hourArray{
    if (_hourArray == nil) {
        _hourArray = [NSMutableArray array];
        for (int i=0; i<24; i++) {
            NSString *hourStr = [NSString stringWithFormat:@"%02d",i];
            [_hourArray addObject:hourStr];
        }
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray{
    if (_minuteArray == nil) {
        _minuteArray = [NSMutableArray array];
        for (int i=0; i<60; i++) {
            NSString *hourStr = [NSString stringWithFormat:@"%02d",i];
            [_minuteArray addObject:hourStr];
        }
    }
    return _minuteArray;
}

+ (instancetype)pickerView{
    return [[self alloc] initWithFrame:SXKeyWindow.bounds];
}

- (void)showPickerView{
    
    [SXDelegateWindow addSubview:self];
    
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SXDatePickerViewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT-SXDatePickerViewHeight, SCREEN_WIDTH, SXDatePickerViewHeight);
    }];
}

- (void)hidePickerView{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SXDatePickerViewHeight);
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

#pragma mark -初始化UI-
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
    UIPickerView *datePicker = [ [ UIPickerView alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColorFromRGB(0xf5f5f5);
    datePicker.tintColor = SXColorBlue;
    datePicker.dataSource = self;
    datePicker.delegate = self;
    datePicker.showsSelectionIndicator = YES;
    [self.contentBgView addSubview:datePicker];
    self.datePicker = datePicker;
    
    //4.添加头部视图
    UIView *topBgView = [[UIView alloc] init];
    topBgView.backgroundColor = UIColor.whiteColor;
    [self.contentBgView addSubview:topBgView];
    self.topBgView = topBgView;
    
    UIView *bottomBgView = [[UIView alloc] init];
    bottomBgView.backgroundColor = UIColor.whiteColor;
    [self.contentBgView addSubview:bottomBgView];
    self.bottomBgView = bottomBgView;
    
    //5.取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:SXColor4A5A78 forState:UIControlStateNormal];
    [cancleButton setTitleColor:SXColor4A5A78 forState:UIControlStateHighlighted];
    [cancleButton setBackgroundColor:SXColorF2F2F2];
    //[cancleButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [cancleButton addTarget:self action:@selector(cancleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBgView addSubview:cancleButton];
    self.cancleButton = cancleButton;
    [self.cancleButton roundViewWithRadius:4.0f];
    
    //6.完成按钮
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //[confirmButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"img_button_bg_small"] forState:UIControlStateNormal];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBgView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    [self.confirmButton roundViewWithRadius:4.0f];
    
    //7.选择日期
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textColor = SXColor2B3852;
    titleL.font = SXFontBold18;
    titleL.text = @"选择时间";
    [self.topBgView addSubview:titleL];
    self.titleL = titleL;
    
    //初始化默认值
    self.hourStr = @"00";
    self.minuteStr = @"00";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(SXDatePickerViewHeight);
    }];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.right.mas_equalTo(self.contentBgView.mas_right);
        make.top.mas_equalTo(self.contentBgView.mas_top);
        make.height.mas_equalTo(40);
    }];
    
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.bottom.mas_equalTo(self.contentBgView.mas_bottom);
        make.right.mas_equalTo(self.contentBgView.mas_right);
        make.height.mas_equalTo(SXDatePickerBottomHeight);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.top.mas_equalTo(self.topBgView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomBgView.mas_top);
        make.right.mas_equalTo(self.contentBgView.mas_right);
    }];
    
    //----//----//----//----//----//----
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomBgView).mas_offset(10);
        make.top.mas_equalTo(self.bottomBgView).mas_offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 15);
        make.height.mas_equalTo(45);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomBgView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.bottomBgView).mas_offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 15);
        make.height.mas_equalTo(45);
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
    if (self.confirmBtnBlock) {
        NSString *timeStr = [NSString stringWithFormat:@"%@:%@",self.hourStr,self.minuteStr];
        self.confirmBtnBlock(timeStr);
    }
    if (self.hourStr.length && self.minuteStr.length) {
        [self cancleButtonTapped];
    }
}

#pragma mark -UIPickerViewDataSource/UIPickerViewDelegate-
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.hourArray.count;
    }else if (component == 1) {
        return self.minuteArray.count;
    }else {
        return 0;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
        pickerLabel.textColor = SXColor2B3852;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - UIPicker Delegate -
/**
 *  pickerView第component列的第row行显示的字符串
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        self.hourStr = [self.hourArray objectAtIndex:row];
        return [NSString stringWithFormat:@"%@时",self.hourStr];
    } else if (component == 1) {
        self.minuteStr = [self.minuteArray objectAtIndex:row];
        return [NSString stringWithFormat:@"%@时",self.minuteStr];
    } else {
        return nil;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return SCREEN_WIDTH/2.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

/**
 *  当选中了pickerView的第component列的第row行会调用这个方法
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // 如果第0列有变化，就刷新第1列的数据，并且让第1列选中第0行，然后刷新第2列并让第2列选中第0列
    if (component == 0) {
        self.hourStr = [self.hourArray objectAtIndex:row];
    }
    
    // 如果第1列有变化，就刷新第2列并让第2列选中第0列
    if (component == 1) {
        self.minuteStr = [self.minuteArray objectAtIndex:row];
    }
}

@end
