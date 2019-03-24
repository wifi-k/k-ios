//
//  SXUpdateVersionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeXiaoKiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXUpdateVersionHeaderView : UIView

+ (instancetype)headerView;

@property (nonatomic, strong) SXHomeXiaoKiModel *model;

///点击升级按钮回调
@property (nonatomic, copy) void (^clickUpdateBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
