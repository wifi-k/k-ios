//
//  SXForbiddenAppFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppFooterView.h"

@interface SXForbiddenAppFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation SXForbiddenAppFooterView

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
    
    [self.addBtn roundViewWithRadius:22.5f];
}

- (IBAction)clickAddBtn:(UIButton *)sender {
    if (self.clickAddForbiddenBlock) {
        self.clickAddForbiddenBlock();
    }
}

@end
