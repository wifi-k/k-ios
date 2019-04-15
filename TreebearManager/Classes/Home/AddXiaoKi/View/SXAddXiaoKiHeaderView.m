//
//  SXAddXiaoKiHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAddXiaoKiHeaderView.h"

@interface SXAddXiaoKiHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *tipsL;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@end

@implementation SXAddXiaoKiHeaderView

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
    
    self.tipsL.textColor = SXColor2B3852;
    
    [self.confirmBtn roundViewWithRadius:6.0f];
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock();
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.tipsL.text = title;
}

@end
