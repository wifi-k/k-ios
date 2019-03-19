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
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorBlue;
}

@end
