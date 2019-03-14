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
    CGFloat itemW = SCREEN_WIDTH/2.5f;
    CGFloat itemH = 120;
    CGFloat imageW = itemW - 20;
    self.scrollView.contentSize = CGSizeMake(3*itemW, 120);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i=0; i<3; i++) {
        itemX = i * itemW;
        UIView *itemBgV = [[UIView alloc] init];
        itemBgV.frame = CGRectMake(itemX, itemY, itemW, itemH);
        itemBgV.backgroundColor = SXColorWhite;
        itemBgV.tag = i + 10;
        [self.scrollView addSubview:itemBgV];
    }
    
    UIView *itemBgV1 = [self.scrollView viewWithTag:10];
    UIView *itemBgV2 = [self.scrollView viewWithTag:11];
    UIView *itemBgV3 = [self.scrollView viewWithTag:12];
    
    UIImageView *imageV1 = [[UIImageView alloc] init];
    imageV1.contentMode = UIViewContentModeScaleAspectFill;
    //阴影
    imageV1.backgroundColor = SXColorRandom;
    imageV1.layer.cornerRadius = 5;
    imageV1.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    imageV1.layer.shadowOffset = CGSizeMake(3, 3);
    imageV1.layer.shadowOpacity = 0.5;
    imageV1.layer.shadowRadius = 3;
    [itemBgV1 addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.centerY.mas_equalTo(itemBgV1);
        make.centerX.mas_equalTo(itemBgV1).mas_offset(5);
    }];
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.contentMode = UIViewContentModeScaleAspectFill;
    //阴影
    imageV2.backgroundColor = SXColorRandom;
    imageV2.layer.cornerRadius = 5;
    imageV2.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    imageV2.layer.shadowOffset = CGSizeMake(3, 3);
    imageV2.layer.shadowOpacity = 0.5;
    imageV2.layer.shadowRadius = 3;
    [itemBgV2 addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.center.mas_equalTo(itemBgV2);
    }];
    
    UIImageView *imageV3 = [[UIImageView alloc] init];
    imageV3.contentMode = UIViewContentModeScaleAspectFill;
    //阴影
    imageV3.backgroundColor = SXColorRandom;
    imageV3.layer.cornerRadius = 5;
    imageV3.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    imageV3.layer.shadowOffset = CGSizeMake(3, 3);
    imageV3.layer.shadowOpacity = 0.5;
    imageV3.layer.shadowRadius = 3;
    [itemBgV3 addSubview:imageV3];
    [imageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.centerY.mas_equalTo(itemBgV3);
        make.centerX.mas_equalTo(itemBgV3).mas_offset(-5);
    }];
}

@end
