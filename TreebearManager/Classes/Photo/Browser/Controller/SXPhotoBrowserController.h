//
//  SXPhotoBrowserController.h
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPhotoBrowserController : UIViewController

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///索引
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
