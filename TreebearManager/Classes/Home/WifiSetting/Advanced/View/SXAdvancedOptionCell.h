//
//  SXAdvancedOptionCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXAdvancedOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXAdvancedOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXAdvancedOptionModel *model;

@end

NS_ASSUME_NONNULL_END
