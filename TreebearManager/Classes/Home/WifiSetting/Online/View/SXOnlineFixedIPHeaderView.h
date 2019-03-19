//
//  SXOnlineFixedIPHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXOnlineFixedIPHeaderView : UIView

+ (instancetype)headerView;

///点击保存选项回调
@property (nonatomic, copy) void (^clickSaveBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
