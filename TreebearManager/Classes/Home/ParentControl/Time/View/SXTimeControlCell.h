//
//  SXTimeControlCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXTimeControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeControlCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///禁用方案模型
@property (nonatomic, strong) SXTimeControlModel *model;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(SXTimeControlModel *model);
///点击删除按钮回调
@property (nonatomic, copy) void (^clickDeleteBtnBlock)(SXTimeControlModel *model);

@end

NS_ASSUME_NONNULL_END
