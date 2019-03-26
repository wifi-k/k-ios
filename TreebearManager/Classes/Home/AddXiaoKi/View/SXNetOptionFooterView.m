//
//  SXNetOptionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetOptionFooterView.h"

@interface SXNetOptionFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation SXNetOptionFooterView

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
    
    [self.nextBtn roundViewWithRadius:6.0f];
}

#pragma mark -setter-
- (void)setBtnEnabled:(BOOL)enabled{
    self.nextBtn.enabled = enabled;
}

#pragma mark -点击事件-
- (IBAction)clickNextBtn:(UIButton *)sender {
    for (SXNetOptionModel *model in self.dataArray) {
        if (model.selected.boolValue) {
            if (self.clickNextBtnBlock) {
                self.clickNextBtnBlock(model);
            }
        }
    }
}

@end
