//
//  SXBaseTableViewCell.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseTableViewCell : UITableViewCell

+ (instancetype)cellFromNib:(UITableView *)tableView;
+ (instancetype)cellFromClass:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
