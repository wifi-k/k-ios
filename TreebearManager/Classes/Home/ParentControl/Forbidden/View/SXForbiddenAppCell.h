//
//  SXForbiddenAppCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXForbiddenAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///禁用方案模型
@property (nonatomic, strong) SXForbiddenAppModel *model;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(SXForbiddenAppModel *model);
///点击删除按钮回调
@property (nonatomic, copy) void (^clickDeleteBtnBlock)(SXForbiddenAppModel *model);

@end

NS_ASSUME_NONNULL_END
