//
//  SXParentControlHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXParentControlHeaderView : UIView

+ (instancetype)headerView;

///点击禁用App按钮回调
@property (nonatomic, copy) void (^clickForbiddenAppBlock)(void);
///点击时间控制按钮回调
@property (nonatomic, copy) void (^clickTimeControlBlock)(void);

@end

NS_ASSUME_NONNULL_END
