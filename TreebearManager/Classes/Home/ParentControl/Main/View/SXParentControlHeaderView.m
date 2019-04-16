//
//  SXParentControlHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXParentControlHeaderView.h"

@interface SXParentControlHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@end

@implementation SXParentControlHeaderView

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
    
    self.backgroundColor = SXColorWhite;
    
    self.topImageView.contentMode = UIViewContentModeCenter;
}

#pragma mark -点击事件-
- (IBAction)clickForbiddenBtn:(UIButton *)sender {
    if (self.clickForbiddenAppBlock) {
        self.clickForbiddenAppBlock();
    }
}

- (IBAction)clickTimeControlBtn:(UIButton *)sender {
    if (self.clickTimeControlBlock) {
        self.clickTimeControlBlock();
    }
}

@end

