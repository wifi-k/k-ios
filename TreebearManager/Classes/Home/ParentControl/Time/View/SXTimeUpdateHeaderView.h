//
//  SXTimeUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTimeControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeUpdateHeaderView : UIView

+ (instancetype)headerView;

///时间模型
@property (nonatomic, strong) SXTimeControlModel *model;

- (void)setUpData;

- (void)selectTime;

- (void)selectDevice;

- (BOOL)isSelectedAll;

///点击更新名称回调
@property (nonatomic, copy) void (^clickUpdateNameBtnBlock)(void);

///点击禁用的App回调
@property (nonatomic, copy) void (^clickTimeControlAppBlock)(void);

///点击设备控制回调
@property (nonatomic, copy) void (^clickDeviceControlBlock)(void);

@end

NS_ASSUME_NONNULL_END
