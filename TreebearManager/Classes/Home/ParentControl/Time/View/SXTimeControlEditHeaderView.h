//
//  SXTimeControlEditHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTimeControlParam.h"
#import "SXTimeControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeControlEditHeaderView : UIView

+ (instancetype)headerView;

///时间控制模型
@property (nonatomic, strong) SXTimeControlModel *model;

///点击开始时间回调
@property (nonatomic, copy) void (^clickBeginTimeControlBlock)(void);
///点击结束时间回调
@property (nonatomic, copy) void (^clickEndTimeControlBlock)(void);
///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(SXTimeControlParam *param);

///开始时间
@property (nonatomic, copy) NSString *beginTimeStr;
///结束时间
@property (nonatomic, copy) NSString *endTimeStr;

@end

NS_ASSUME_NONNULL_END
