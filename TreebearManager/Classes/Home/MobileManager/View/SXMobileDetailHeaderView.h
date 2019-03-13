//
//  SXMobileDetailHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXMobileDetailHeaderView : UIView

+ (instancetype)headerView;

///点击设备信息回调
@property (nonatomic, copy) void (^clickCenterFirstBgViewBlock)(void);

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
