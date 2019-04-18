//
//  SXPhotoOptionPickerView.m
//  TreebearManager
//
//  Created by bear on 2019/4/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoOptionPickerView.h"
#import "SXPhotoOptionPickerButton.h"

#define SXPhotoOptionPickerViewHeight 170

@interface SXPhotoOptionPickerView ()
@property (nonatomic, weak) UIView *bgView;//背景视图
@property (nonatomic, weak) UIView *contentBgView;//内容背景视图
@property (nonatomic, weak) UIView *topBgView;//头部背景视图
@property (nonatomic, weak) UIView *bottomBgView;//底部背景视图
@property (nonatomic, weak) SXPhotoOptionPickerButton *leftButton;//左边按钮
@property (nonatomic, weak) SXPhotoOptionPickerButton *rightButton;//右边按钮
@property (nonatomic, weak) UIButton *cancleButton;//取消按钮
@end

@implementation SXPhotoOptionPickerView

+ (instancetype)pickerView{
    return [[self alloc] initWithFrame:SXKeyWindow.bounds];
}

- (void)showPickerView{
    
    [SXDelegateWindow addSubview:self];
    
    self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SXPhotoOptionPickerViewHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT-SXPhotoOptionPickerViewHeight, SCREEN_WIDTH, SXPhotoOptionPickerViewHeight);
    }];
}

- (void)hidePickerView{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        self.contentBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SXPhotoOptionPickerViewHeight);
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
    
    //4.添加头部视图
    UIView *topBgView = [[UIView alloc] init];
    topBgView.backgroundColor = SXColorDivideLine;
    [self.contentBgView addSubview:topBgView];
    self.topBgView = topBgView;
    
    UIView *bottomBgView = [[UIView alloc] init];
    bottomBgView.backgroundColor = UIColor.whiteColor;
    [self.contentBgView addSubview:bottomBgView];
    self.bottomBgView = bottomBgView;
    
    //1.选项按钮
    SXPhotoOptionPickerButton *leftButton = [SXPhotoOptionPickerButton buttonWithType:UIButtonTypeCustom];
    leftButton.tag = 0;
    [leftButton setTitle:@"拍照" forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"img_photo_take"] forState:UIControlStateNormal];
    [leftButton setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [leftButton setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [leftButton setBackgroundColor:SXColorWhite];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [leftButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBgView addSubview:leftButton];
    self.leftButton = leftButton;
    
    //2.选项按钮
    SXPhotoOptionPickerButton *rightButton = [SXPhotoOptionPickerButton buttonWithType:UIButtonTypeCustom];
    rightButton.tag = 1;
    [rightButton setTitle:@"从相册选择" forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"img_photo_photo"] forState:UIControlStateNormal];
    [rightButton setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [rightButton setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:SXColorWhite];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [rightButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBgView addSubview:rightButton];
    self.rightButton = rightButton;
    
    //3.取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [cancleButton setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [cancleButton setBackgroundColor:SXColorWhite];
    //[cancleButton setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [cancleButton addTarget:self action:@selector(cancleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBgView addSubview:cancleButton];
    self.cancleButton = cancleButton;
    [self.cancleButton roundViewWithRadius:4.0f];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(SXPhotoOptionPickerViewHeight);
    }];
    
    [self.topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.right.mas_equalTo(self.contentBgView.mas_right);
        make.top.mas_equalTo(self.contentBgView.mas_top);
        make.height.mas_equalTo(120);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topBgView);
        make.top.mas_equalTo(self.topBgView);
        make.width.mas_equalTo(SCREEN_WIDTH/2.0 - 0.5f);
        make.height.mas_equalTo(120 - 1.0f);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topBgView.mas_right);
        make.top.mas_equalTo(self.topBgView);
        make.width.mas_equalTo(SCREEN_WIDTH/2.0 - 0.5f);
        make.height.mas_equalTo(120 - 1.0f);
    }];
    
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentBgView);
        make.bottom.mas_equalTo(self.contentBgView.mas_bottom);
        make.right.mas_equalTo(self.contentBgView.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    //----//----//----//----//----//----
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomBgView);
        make.top.mas_equalTo(self.bottomBgView);
        make.right.mas_equalTo(self.bottomBgView.mas_right);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark -点击事件-
- (void)clickBtn:(UIButton *)btn{
    if (self.confirmBtnBlock) {
        self.confirmBtnBlock(btn.tag);
    }
    [self hidePickerView];
}

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
    
}

@end
