//
//  SXBaseEmptyDataView.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseEmptyDataView.h"

@interface SXBaseEmptyDataView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation SXBaseEmptyDataView

+ (instancetype)initWithImage:(NSString *)imageName title:(NSString *)title{
    SXBaseEmptyDataView *noDataView = [[self alloc] initWithFrame:CGRectZero];
    noDataView.imageView.image = [UIImage imageNamed:imageName];
    noDataView.titleL.text = title;
    
    CGSize imageSize = noDataView.imageView.image.size;
    CGFloat imageScale = imageSize.width/imageSize.height;
    [noDataView.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@(150/imageScale));
        make.centerX.mas_equalTo(noDataView.mas_centerX);
        make.centerY.mas_equalTo(noDataView.mas_centerY).mas_offset(@(-45/2));
    }];
    [noDataView.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noDataView.mas_left).mas_offset(@25);
        make.right.mas_equalTo(noDataView.mas_right).mas_offset(@-25);
        make.height.mas_equalTo(@25);
        make.top.mas_equalTo(noDataView.imageView.mas_bottom).mas_offset(@20);
    }];
    return noDataView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        [self addSubview:self.titleL];
    }
    return self;
}

#pragma mark - GET/SET
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleL.textColor = UIColor.redColor;
        _titleL.font = [UIFont systemFontOfSize:13.0f];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

@end
