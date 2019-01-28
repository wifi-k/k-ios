//
//  SXBaseCollectionViewCell.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseCollectionViewCell : UICollectionViewCell

+ (instancetype)collectionViewCellFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)collectionViewCellFromClass:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
