//
//  SXLoginHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXLoginHeaderView : UIView

+ (instancetype)headerView;

///点击登录按钮回调
@property (nonatomic, copy) void (^clickLoginBtnBlock)(void);
@property (nonatomic, copy) void (^clickCodeLoginBtnBlock)(void);
@property (nonatomic, copy) void (^clickForgetBtnBlock)(void);
    
@end
