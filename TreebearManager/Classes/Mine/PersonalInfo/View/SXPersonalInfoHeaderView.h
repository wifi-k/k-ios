//
//  SXPersonalInfoHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXPersonalInfoHeaderView : UIView

+ (instancetype)headerView;

///点击关于我们
@property (nonatomic, copy) void (^clickIconBgViewBlock)(void);
///点击关于我们
@property (nonatomic, copy) void (^clickNickNameBgViewBlock)(void);
///点击关于我们
@property (nonatomic, copy) void (^clickMobileBgViewBlock)(void);
///点击关于我们
@property (nonatomic, copy) void (^clickPasswordBgViewBlock)(void);

@end

NS_ASSUME_NONNULL_END
