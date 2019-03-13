//
//  SXOnlineBroadbandHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXOnlineBroadbandHeaderView : UIView

+ (instancetype)headerView;

///点击断开按钮回调
@property (nonatomic, copy) void (^clickDisconnectedBtnBlock)(void);

///点击连接按钮回调
@property (nonatomic, copy) void (^clickConnectedBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END