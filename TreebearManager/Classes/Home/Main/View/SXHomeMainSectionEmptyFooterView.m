//
//  SXHomeMainSectionEmptyFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionEmptyFooterView.h"

@interface SXHomeMainSectionEmptyFooterView ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *subTitleL;


@end

@implementation SXHomeMainSectionEmptyFooterView

+ (instancetype)footerViewWithImageName:(NSString *)imageName title:(NSString *)title subTitle:(NSString *)subTitle{
    SXHomeMainSectionEmptyFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    footerView.topImageView.image = [UIImage imageNamed:imageName];
    footerView.titleL.text = title;
    footerView.subTitleL.text = subTitle;
    return footerView;
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
    
    self.titleL.textColor = SXColor333333;
    self.titleL.font = SXFontBold18;
    self.subTitleL.textColor = SXColor999999;
}

@end
