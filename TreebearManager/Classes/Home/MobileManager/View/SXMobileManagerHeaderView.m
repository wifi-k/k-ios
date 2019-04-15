//
//  SXMobileManagerHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileManagerHeaderView.h"

@interface SXMobileManagerHeaderView ()
@property (weak, nonatomic) UILabel *l1;
@property (weak, nonatomic) UILabel *l11;
@property (weak, nonatomic) UILabel *l2;
@property (weak, nonatomic) UILabel *l22;
@property (weak, nonatomic) UILabel *l3;
@property (weak, nonatomic) UILabel *l33;
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
    self.titleL.textColor = SXColor2B3852;
    
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
    imageV1.image = [UIImage imageNamed:@"img_networking_bg1"];
    //阴影
//    imageV1.backgroundColor = SXColorRandom;
//    imageV1.layer.cornerRadius = 5;
//    imageV1.layer.shadowColor = UIColor.lightGrayColor.CGColor;
//    imageV1.layer.shadowOffset = CGSizeMake(3, 3);
//    imageV1.layer.shadowOpacity = 0.5;
//    imageV1.layer.shadowRadius = 3;
    [itemBgV1 addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.centerY.mas_equalTo(itemBgV1);
        make.centerX.mas_equalTo(itemBgV1).mas_offset(5);
    }];
    
    UIImageView *imageV2 = [[UIImageView alloc] init];
    imageV2.contentMode = UIViewContentModeScaleAspectFill;
    imageV2.image = [UIImage imageNamed:@"img_networking_bg2"];
    //阴影
//    imageV2.backgroundColor = SXColorRandom;
//    imageV2.layer.cornerRadius = 5;
//    imageV2.layer.shadowColor = UIColor.lightGrayColor.CGColor;
//    imageV2.layer.shadowOffset = CGSizeMake(3, 3);
//    imageV2.layer.shadowOpacity = 0.5;
//    imageV2.layer.shadowRadius = 3;
    [itemBgV2 addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.center.mas_equalTo(itemBgV2);
    }];
    
    UIImageView *imageV3 = [[UIImageView alloc] init];
    imageV3.contentMode = UIViewContentModeScaleAspectFill;
    imageV3.image = [UIImage imageNamed:@"img_networking_bg3"];
    //阴影
//    imageV3.backgroundColor = SXColorRandom;
//    imageV3.layer.cornerRadius = 5;
//    imageV3.layer.shadowColor = UIColor.lightGrayColor.CGColor;
//    imageV3.layer.shadowOffset = CGSizeMake(3, 3);
//    imageV3.layer.shadowOpacity = 0.5;
//    imageV3.layer.shadowRadius = 3;
    [itemBgV3 addSubview:imageV3];
    [imageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, 100));
        make.centerY.mas_equalTo(itemBgV3);
        make.centerX.mas_equalTo(itemBgV3).mas_offset(-5);
    }];
    
    UILabel *l1 = [[UILabel alloc] init];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.text = @"1000";
    l1.textColor = SXColorWhite;
    l1.font = SXFontBold18;
    [imageV1 addSubview:l1];
    self.l1 = l1;
    [l1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV1).mas_offset(5);
        make.right.mas_equalTo(imageV1).mas_offset(-5);
        make.centerY.mas_equalTo(imageV1).mas_offset(-12);
    }];
    
    UILabel *l11 = [[UILabel alloc] init];
    l11.textAlignment = NSTextAlignmentCenter;
    l11.text = @"上网限速";
    l11.textColor = SXColorWhite;
    l11.font = SXFont16;
    [imageV1 addSubview:l11];
    self.l11 = l11;
    [l11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV1).mas_offset(5);
        make.right.mas_equalTo(imageV1).mas_offset(-5);
        make.centerY.mas_equalTo(imageV1).mas_offset(12);
    }];
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.textAlignment = NSTextAlignmentCenter;
    l2.text = @"1000";
    l2.textColor = SXColorWhite;
    l2.font = SXFontBold18;
    [imageV2 addSubview:l2];
    self.l2 = l2;
    [l2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV2).mas_offset(5);
        make.right.mas_equalTo(imageV2).mas_offset(-5);
        make.centerY.mas_equalTo(imageV2).mas_offset(-12);
    }];
    
    UILabel *l22 = [[UILabel alloc] init];
    l22.textAlignment = NSTextAlignmentCenter;
    l22.text = @"上网限速";
    l22.textColor = SXColorWhite;
    l22.font = SXFont16;
    [imageV2 addSubview:l22];
    self.l22 = l22;
    [l22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV2).mas_offset(5);
        make.right.mas_equalTo(imageV2).mas_offset(-5);
        make.centerY.mas_equalTo(imageV2).mas_offset(12);
    }];
    
    UILabel *l3 = [[UILabel alloc] init];
    l3.textAlignment = NSTextAlignmentCenter;
    l3.text = @"1000";
    l3.textColor = SXColorWhite;
    l3.font = SXFontBold18;
    [imageV3 addSubview:l3];
    self.l3 = l3;
    [l3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV3).mas_offset(5);
        make.right.mas_equalTo(imageV3).mas_offset(-5);
        make.centerY.mas_equalTo(imageV3).mas_offset(-12);
    }];
    
    UILabel *l33 = [[UILabel alloc] init];
    l33.textAlignment = NSTextAlignmentCenter;
    l33.text = @"上网限速";
    l33.textColor = SXColorWhite;
    l33.font = SXFont16;
    [imageV3 addSubview:l33];
    self.l33 = l33;
    [l33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV3).mas_offset(5);
        make.right.mas_equalTo(imageV3).mas_offset(-5);
        make.centerY.mas_equalTo(imageV3).mas_offset(12);
    }];
}

#pragma mark -setter-
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.l1.text = title;
    self.l11.text = title;
    self.l2.text = title;
    self.l22.text = title;
    self.l3.text = title;
    self.l33.text = title;
}

@end
