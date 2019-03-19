//
//  SXHomeReportReusableView.h
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeReportReusableView : UICollectionReusableView

///初始化UI
+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
