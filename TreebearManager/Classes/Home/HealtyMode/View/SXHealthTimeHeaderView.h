//
//  SXHealthTimeHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHealtyControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealthTimeHeaderView : UIView

+ (instancetype)headerView;

///模型
@property (nonatomic, strong) SXHealtyControlTimeModel *model;

///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(SXHealtyControlTimeModel *model);
///点击开始时间回调
@property (nonatomic, copy) void (^clickBeginTimeControlBlock)(NSString *text);
///点击结束时间回调
@property (nonatomic, copy) void (^clickEndTimeControlBlock)(NSString *text);

///开始时间
@property (nonatomic, copy) NSString *startTimeStr;
///结束时间
@property (nonatomic, copy) NSString *endTimeStr;
@end

NS_ASSUME_NONNULL_END
