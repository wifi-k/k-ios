//
//  SXPhotoSectionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoSectionHeaderView.h"

@interface SXPhotoSectionHeaderView ()
@property (weak, nonatomic) UILabel *titleL;
@end

@implementation SXPhotoSectionHeaderView

+ (instancetype)sectionHeaderAwakeFromClass:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    [collectionView registerClass:self forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //1.设置白色背景
        self.backgroundColor = [UIColor whiteColor];
        //2.初始化UI
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = SXFontBold23;
    titleL.textColor = SXColor333333;
    [self addSubview:titleL];
    self.titleL = titleL;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}

@end
