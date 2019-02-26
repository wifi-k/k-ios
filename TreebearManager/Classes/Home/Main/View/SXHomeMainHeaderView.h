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

///点击消息按钮回调
@property (nonatomic, copy) void (^clickMessageBgViewBlock)(void);
///点击设置按钮回调
@property (nonatomic, copy) void (^clickSettingBtnBlock)(NSInteger tag);
///点击我的小K回调
@property (nonatomic, copy) void (^clickUserInfoBtnBlock)(void);
///点击备份按钮回调
@property (nonatomic, copy) void (^clickBackupBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
