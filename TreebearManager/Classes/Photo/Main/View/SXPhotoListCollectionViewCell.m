//
//  SXPhotoListCollectionViewCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoListCollectionViewCell.h"

@interface SXPhotoListCollectionViewCell ()

@end

@implementation SXPhotoListCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:SXPhotoListCollectionViewCellID forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    
}

@end
