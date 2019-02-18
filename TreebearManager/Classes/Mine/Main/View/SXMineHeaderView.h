//
//  SXMineHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXMineHeaderView : UIView

+ (instancetype)headerView;

///点击登录按钮回调
@property (nonatomic, copy) void (^clickBindingBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
