//
//  SXHealtyControlCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHealtyControlModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///模型
@property (nonatomic, strong) SXHealtyControlModel *model;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(SXHealtyControlModel *model);

@end

NS_ASSUME_NONNULL_END
