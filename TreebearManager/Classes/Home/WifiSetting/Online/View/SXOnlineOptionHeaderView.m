//
//  SXOnlineOptionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineOptionHeaderView.h"

@interface SXOnlineOptionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXOnlineOptionHeaderView


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
    
    self.titleL.font = SXFontBold18;
    self.titleL.textColor = SXColor333333;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
    
    [self.optionBtn setTitleColor:SXColor666666 forState:UIControlStateNormal];
}

#pragma mark -setter-
- (void)setOptionStr:(NSString *)optionStr{
    _optionStr = optionStr;
    
    [self.optionBtn setTitle:optionStr forState:UIControlStateNormal];
}

#pragma mark -点击菜单视图-
- (IBAction)clickOptionBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.clickOptionBtnBlock) {
        self.clickOptionBtnBlock(sender.selected);
    }
}

@end
