//
//  SXOnlineOptionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXOnlineOptionHeaderView : UIView

+ (instancetype)headerView;

///点击菜单按钮回调
@property (nonatomic, copy) void (^clickOptionBtnBlock)(void);

///菜单按钮
@property (nonatomic, weak) UIButton *menuBtn;

@end

NS_ASSUME_NONNULL_END
