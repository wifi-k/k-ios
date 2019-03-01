//
//  SXForbiddenUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenUpdateHeaderView : UIView

+ (instancetype)headerView;

///点击时间控制回调
@property (nonatomic, copy) void (^clickTimeControlBlock)(void);

///点击设备控制回调
@property (nonatomic, copy) void (^clickDeviceControlBlock)(void);

@end

NS_ASSUME_NONNULL_END
