//
//  SXNetBroadbandHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXNetBroadbandHeaderView : UIView

+ (instancetype)headerView;

///点击确定按钮回调
@property (nonatomic, copy) void (^clickConfirmBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
