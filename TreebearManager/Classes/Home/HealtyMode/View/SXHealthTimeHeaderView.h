//
//  SXHealthTimeHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHealthTimeHeaderView : UIView

+ (instancetype)headerView;

///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);
///点击开始时间回调
@property (nonatomic, copy) void (^clickBeginTimeControlBlock)(void);
///点击结束时间回调
@property (nonatomic, copy) void (^clickEndTimeControlBlock)(void);

@end

NS_ASSUME_NONNULL_END
