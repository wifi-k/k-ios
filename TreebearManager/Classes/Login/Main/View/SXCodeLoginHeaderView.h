//
//  SXCodeLoginHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXLoginParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXCodeLoginHeaderView : UIView

+ (instancetype)headerView;

///点击登录按钮回调
@property (nonatomic, copy) void (^clickLoginBtnBlock)(void);

///登录参数
@property (nonatomic, strong) SXLoginParam *param;

@end

NS_ASSUME_NONNULL_END
