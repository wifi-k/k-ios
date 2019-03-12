//
//  SXOnlineAutotIPHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXOnlineAutotIPHeaderView : UIView

+ (instancetype)headerView;

///点击更新按钮回调
@property (nonatomic, copy) void (^clickUpdateIPBtnBlock)(void);

///点击高级选项回调
@property (nonatomic, copy) void (^clickAdvancedBgViewBlock)(void);



@end

NS_ASSUME_NONNULL_END
