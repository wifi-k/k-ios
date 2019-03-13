//
//  SXPersonalInfoHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPersonalInfoHeaderView.h"

@interface SXPersonalInfoHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

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
