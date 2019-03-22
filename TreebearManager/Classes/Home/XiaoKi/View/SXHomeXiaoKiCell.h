//
//  SXHomeXiaoKiCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeXiaoKiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeXiaoKiCell : UITableViewCell

///小K模型
@property(nonatomic, strong) SXHomeXiaoKiModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///点击修改名称回调
@property (nonatomic, copy) void (^clickUpdateNameBtnBlock)(void);
///点击解绑按钮回调
@property (nonatomic, copy) void (^clickUnbindBtnBlock)(SXHomeXiaoKiModel *model);
///点击升级版本回调
@property (nonatomic, copy) void (^clickUpdateVersionBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
