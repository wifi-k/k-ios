//
//  SXHomeHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeHeaderView.h"

@interface SXHomeHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
    
@property (weak, nonatomic) IBOutlet UIButton *bindingDeviceBtn;
@end

@implementation SXHomeHeaderView

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
    
    self.backgroundColor = SXColorRandom;
    
    self.topImageV.backgroundColor = SXColorRandom;
}
    
- (IBAction)clickBindingBtn:(UIButton *)sender {
    if (self.clickBindingBtnBlock) {
        self.clickBindingBtnBlock();
    }
}
    
@end
