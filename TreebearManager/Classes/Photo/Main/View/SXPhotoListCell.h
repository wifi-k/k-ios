//
//  SXPhotoListCollectionViewCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SXPhotoListCollectionViewCellID = @"SXPhotoListCollectionViewCellID";

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoListCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
