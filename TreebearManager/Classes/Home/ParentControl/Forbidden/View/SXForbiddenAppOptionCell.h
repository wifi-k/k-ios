//
//  SXForbiddenAppOptionCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXForbiddenAppOptionModel.h"

static NSString *const SXForbiddenAppOptionCellID = @"SXForbiddenAppOptionCellID";

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppOptionCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) SXForbiddenAppOptionModel *model;

@end

NS_ASSUME_NONNULL_END
