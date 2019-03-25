//
//  SXLoginMainHeaderView.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXLoginMainHeaderView : UIView

+ (instancetype)headerView;

///是否隐藏Icons
- (void)hideIcons:(BOOL)isHidden;

///点击登录按钮回调
@property (nonatomic, copy) void (^clickLoginBtnBlock)(void);
///点击忘记密码按钮回调
@property (nonatomic, copy) void (^clickRegistBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
