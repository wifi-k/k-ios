//
//  SXUpdateVersionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUpdateVersionHeaderView.h"

@interface SXUpdateVersionHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@end


@implementation SXUpdateVersionHeaderView

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
    
    [self.statusBtn roundViewWithRadius:4.0f];
    
    [self.updateBtn roundViewWithRadius:6.0f];
}

#pragma mark -点击事件-
- (IBAction)clickUpdateBtn:(UIButton *)sender {
    if (self.clickUpdateBtnBlock) {
        self.clickUpdateBtnBlock();
    }
}

@end
