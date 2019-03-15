//
//  SXHomeReportCollectionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportCollectionCell.h"

@interface SXHomeReportCollectionCell ()

@end

@implementation SXHomeReportCollectionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:SXHomeReportCollectionCellID forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorBlue;
}

@end
