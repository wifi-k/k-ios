//
//  SXHomeMainHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainHeaderView : UIView
    
+ (instancetype)headerView;

- (void)setUpData;

///点击管理员按钮回调
@property (nonatomic, copy) void (^clickMangerBtnBlock)(void);
///点击分享家庭码按钮回调
@property (nonatomic, copy) void (^clickShareBtnBlock)(void);
///点击nameL回调
@property (nonatomic, copy) void (^clickNameLabelBlock)(void);
///点击消息按钮回调
@property (nonatomic, copy) void (^clickMessageBgViewBlock)(void);
///点击设置按钮回调
@property (nonatomic, copy) void (^clickSettingBtnBlock)(NSInteger tag);
///点击我的小K回调
@property (nonatomic, copy) void (^clickUserInfoBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
