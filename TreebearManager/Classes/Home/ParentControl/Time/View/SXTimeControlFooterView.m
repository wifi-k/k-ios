//
//  SXTimeControlFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/4/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlFooterView.h"

@interface SXTimeControlFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation SXTimeControlFooterView

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

- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
}

- (IBAction)clickAddBtn:(UIButton *)sender {
    if (self.clickAddTimeControlBlock) {
        self.clickAddTimeControlBlock();
    }
}

@end
