//
//  SXHealtyControlHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlHeaderView.h"

@interface SXHealtyControlHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *addTimeBtn;
@end

@implementation SXHealtyControlHeaderView

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
    
    [self.addTimeBtn roundViewWithRadius:22.5f];
}

#pragma mark -点击事件-
- (IBAction)clickEditBtn:(UIButton *)sender {
    if (self.clickEditTimeBlock) {
        self.clickEditTimeBlock();
    }
}

- (IBAction)clickAddBtn:(UIButton *)sender {
    if (self.clickAddTimeBlock) {
        self.clickAddTimeBlock();
    }
}

@end
