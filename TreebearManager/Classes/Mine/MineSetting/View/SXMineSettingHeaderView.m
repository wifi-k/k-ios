//
//  SXMineSettingHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineSettingHeaderView.h"

@interface SXMineSettingHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;


@property (weak, nonatomic) IBOutlet UIView *secondBgView;
@end

@implementation SXMineSettingHeaderView

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
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView1.height = 0.5f;
    
    //添加事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAboutUs)];
    [self.firstBgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUpdateVersion)];
    [self.secondBgView addGestureRecognizer:tap2];
}

#pragma mark -Event-
- (void)clickAboutUs{
    if (self.clickAboutUsBlock) {
        self.clickAboutUsBlock();
    }
}

- (void)clickUpdateVersion{
    if (self.clickUpdateVersionBlock) {
        self.clickUpdateVersionBlock();
    }
}

@end