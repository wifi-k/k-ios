//
//  SXNetOptionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/4/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetOptionHeaderView.h"

@interface SXNetOptionHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SXNetOptionHeaderView

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
    self.titleL.textColor = SXColor2B3852;
    self.titleL.font = SXFontBold21;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}

@end
