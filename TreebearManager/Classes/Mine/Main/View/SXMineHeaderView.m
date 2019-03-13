//
//  SXMineHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineHeaderView.h"

@interface SXMineHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end

@implementation SXMineHeaderView

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

- (void)setUpUI{
    
    self.backgroundColor = SXColorGray8;
    
    [self.iconBtn roundViewWithRadius:30.0f];
}

- (IBAction)clickIconBtn:(UIButton *)sender {
    if (self.clickBindingBtnBlock) {
        self.clickBindingBtnBlock();
    }
}

@end
