//
//  SXForbiddenAppOptionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppOptionCell.h"

@interface SXForbiddenAppOptionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *appNameL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@end

@implementation SXForbiddenAppOptionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:SXForbiddenAppOptionCellID forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorWhite;
    
}

#pragma mark -setter-
- (void)setModel:(SXForbiddenAppOptionModel *)model{
    _model = model;
    
    self.appNameL.text = model.title;
//    self.appImageView.image = [UIImage imageNamed:@""];
}

@end
