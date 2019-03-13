//
//  SXMineVersionUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXMineVersionUpdateHeaderView : UIView

+ (instancetype)headerView;

///点击更新版本回调
@property (nonatomic, copy) void (^clickUpdaeVersionBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
