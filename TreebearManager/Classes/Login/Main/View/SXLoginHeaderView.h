//
//  SXLoginHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXLoginParam.h"

@interface SXLoginHeaderView : UIView

+ (instancetype)headerView;

///点击登录按钮回调
@property (nonatomic, copy) void (^clickLoginBtnBlock)(void);
///点击快捷登录按钮回调
@property (nonatomic, copy) void (^clickCodeLoginBtnBlock)(void);
///点击忘记密码按钮回调
@property (nonatomic, copy) void (^clickForgetBtnBlock)(void);

///登录参数
@property (nonatomic, strong) SXLoginParam *param;
    
@end
