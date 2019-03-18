//
//  SXHealtyControlFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlFooterView.h"

@interface SXHealtyControlFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation SXHealtyControlFooterView

+ (instancetype)footerView{
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
    
    [self.addBtn roundViewWithRadius:6.0f];
}

#pragma mark -event-
- (IBAction)clickAddBtn:(UIButton *)sender {
    if (self.clickAddTimeBlock) {
        self.clickAddTimeBlock();
    }
}

@end
