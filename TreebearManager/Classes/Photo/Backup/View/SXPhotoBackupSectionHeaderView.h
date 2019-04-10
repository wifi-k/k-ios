//
//  SXPhotoBackupSectionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/4/10.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoBackupSectionHeaderView : UICollectionReusableView

///初始化UI
+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

///点击暂停按钮回调
@property (nonatomic, copy) void (^clickBackupBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
