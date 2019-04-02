//
//  SXForbiddenUpdateHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXForbiddenAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenUpdateHeaderView : UIView

+ (instancetype)headerView;

- (void)setUpData;

///禁用方案模型
@property (nonatomic, strong) SXForbiddenAppModel *model;

///点击更新名称回调
@property (nonatomic, copy) void (^clickUpdateNameBtnBlock)(void);

///点击禁用的App回调
@property (nonatomic, copy) void (^clickForbiddenAppBlock)(void);

///点击设备控制回调
@property (nonatomic, copy) void (^clickDeviceControlBlock)(void);

@end

NS_ASSUME_NONNULL_END
