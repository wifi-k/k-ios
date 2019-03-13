//
//  SXOnlineFixedIPHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineFixedIPHeaderView.h"

@interface SXOnlineFixedIPHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstBgView;


@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *thirdBgView;


@property (weak, nonatomic) IBOutlet UIView *fourthBgView;


@property (weak, nonatomic) IBOutlet UIView *fifthBgView;

@end

@implementation SXOnlineFixedIPHeaderView

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

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    self.fifthBgView.backgroundColor = SXColorWhite;
}

@end
