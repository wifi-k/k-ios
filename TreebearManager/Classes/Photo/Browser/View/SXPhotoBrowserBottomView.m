//
//  SXPhotoBrowserBottomView.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserBottomView.h"

@interface SXPhotoBrowserBottomView ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation SXPhotoBrowserBottomView

+ (instancetype)bottomView{
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
    
//    self.backgroundColor = SXColorWhite;
    self.bottomView.backgroundColor = SXColorBlack;
}

- (IBAction)clickOptionBtn:(UIButton *)sender {
    if (self.clickOptionBtnBlock) {
        self.clickOptionBtnBlock(sender.tag);
    }
}


@end
