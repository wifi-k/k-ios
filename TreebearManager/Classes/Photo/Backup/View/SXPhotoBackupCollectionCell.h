//
//  SXPhotoBackupCollectionCell.h
//  TreebearManager
//
//  Created by bear on 2019/4/9.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXAsset.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoBackupCollectionCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) SXAsset  *asset;

@end

NS_ASSUME_NONNULL_END
