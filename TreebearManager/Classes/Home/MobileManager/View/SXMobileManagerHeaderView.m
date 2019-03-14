//
//  SXMobileManagerHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileManagerHeaderView.h"

@interface SXMobileManagerHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SXMobileManagerHeaderView

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
    self.topBgView.backgroundColor = SXColorWhite;
    
    self.titleL.font = SXFontBold18;
    self.titleL.textColor = SXColor333333;
    
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemW = 200.0f;
    CGFloat itemH = 120;
    self.scrollView.contentSize = CGSizeMake(3*itemW, 120);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i=0; i<3; i++) {
        itemX = i * itemW;
        UIView *itemBgV = [[UIView alloc] init];
        itemBgV.frame = CGRectMake(itemX, itemY, itemW, itemH);
        itemBgV.backgroundColor = SXColorRandom;
        [self.scrollView addSubview:itemBgV];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(10, 10, 180, 100);
        imageV.image = [UIImage imageNamed:@"home_top_bg"];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [itemBgV addSubview:imageV];
    }
}

@end
