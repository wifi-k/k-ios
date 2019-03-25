//
//  SXPhotoHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoHeaderView : UICollectionReusableView

///初始化UI
+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

///点击相册按钮
@property (nonatomic, copy) void (^clickOptionBtnBlock)(NSInteger tag);
///点击备份按钮
@property (nonatomic, copy) void (^clickBackupBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
