//
//  SXXiaoKiEquipmentOptionCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeXiaoKiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXXiaoKiEquipmentOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///小K模型
@property(nonatomic, strong) SXHomeXiaoKiModel *model;

@end

NS_ASSUME_NONNULL_END
