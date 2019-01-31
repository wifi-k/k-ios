//
//  SXForgetHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForgetHeaderView.h"

@interface SXForgetHeaderView ()
    
@property (weak, nonatomic) IBOutlet UIButton *clickNextBtn;
@end

@implementation SXForgetHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
    
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}
    
- (void)setUpUI{
    
}

#pragma mark -按钮点击事件-
- (IBAction)clickNextBtn:(UIButton *)sender {
    if (self.clickNextBtnBlock) {
        self.clickNextBtnBlock();
    }
}
    
@end
