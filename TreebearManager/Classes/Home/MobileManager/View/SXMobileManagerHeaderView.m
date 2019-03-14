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
    CGFloat itemW = (SCREEN_WIDTH - 4*10)/2.5f;
    CGFloat itemH = 120;
    self.scrollView.contentSize = CGSizeMake(3*itemW, 120);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i=0; i<3; i++) {
        itemX = i * itemW;
        UIView *itemBgV = [[UIView alloc] init];
        itemBgV.frame = CGRectMake(itemX, itemY, itemW, itemH);
        itemBgV.backgroundColor = SXColorRandom;
        itemBgV.tag = i + 10;
        [self.scrollView addSubview:itemBgV];
    }
    
    UIView *itemBgV1 = [self.scrollView viewWithTag:10];
    UIView *itemBgV2 = [self.scrollView viewWithTag:11];
    UIView *itemBgV3 = [self.scrollView viewWithTag:12];
    
    UIImageView *imageV1 = [[UIImageView alloc] init];
    imageV1.frame = CGRectMake(15, 10, 180, 100);
    imageV1.image = [UIImage imageNamed:@"home_top_bg"];
    imageV1.contentMode = UIViewContentModeScaleAspectFill;
    [imageV1 roundViewWithRadius:6.0f];
    [itemBgV1 addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 100));
        make.centerY.mas_equalTo(itemBgV1);
        make.centerX.mas_equalTo(itemBgV1).mas_offset(5);
    }];
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.image = [UIImage imageNamed:@"home_top_bg"];
    imageV2.contentMode = UIViewContentModeScaleAspectFill;
    [imageV2 roundViewWithRadius:6.0f];
    [itemBgV2 addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 100));
        make.center.mas_equalTo(itemBgV2);
    }];
    
    UIImageView *imageV3 = [[UIImageView alloc] init];
    imageV3.frame = CGRectMake(8, 10, 180, 100);
    imageV3.image = [UIImage imageNamed:@"home_top_bg"];
    imageV3.contentMode = UIViewContentModeScaleAspectFill;
    [imageV3 roundViewWithRadius:6.0f];
    [itemBgV3 addSubview:imageV3];
    [imageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 100));
        make.centerY.mas_equalTo(itemBgV3);
        make.centerX.mas_equalTo(itemBgV3).mas_offset(-5);
    }];
}

@end
