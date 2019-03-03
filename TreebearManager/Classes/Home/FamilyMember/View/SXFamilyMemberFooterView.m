//
//  SXFamilyMemberFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberFooterView.h"

@interface SXFamilyMemberFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addMemberBtn;
@end

@implementation SXFamilyMemberFooterView

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
    
    [self.addMemberBtn roundViewWithRadius:22.5f];
}

- (IBAction)clickAddMemberBtn:(UIButton *)sender {
    if (self.clickAddMemberBlock) {
        self.clickAddMemberBlock();
    }
}

@end
