//
//  SXMineSettingHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXMineSettingHeaderView : UIView

+ (instancetype)headerView;

///点击关于我们
@property (nonatomic, copy) void (^clickAboutUsBlock)(void);
///点击版本更新
@property (nonatomic, copy) void (^clickUpdateVersionBlock)(void);

@end

NS_ASSUME_NONNULL_END
