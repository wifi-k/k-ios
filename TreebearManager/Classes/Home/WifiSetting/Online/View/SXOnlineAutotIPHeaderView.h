//
//  SXOnlineAutotIPHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXXiaoKNodeResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXOnlineAutotIPHeaderView : UIView

+ (instancetype)headerView;

///点击更新按钮回调
@property (nonatomic, copy) void (^clickUpdateIPBtnBlock)(void);

///节点信息结果模型
@property (nonatomic, strong) SXXiaoKNodeResult *result;

@property (nonatomic, assign) NSInteger netStatus;

@end

NS_ASSUME_NONNULL_END
