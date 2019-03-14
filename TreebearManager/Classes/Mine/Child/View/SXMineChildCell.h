//
//  SXMineChildCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMineChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineChildCell : UITableViewCell

///模型
@property (nonatomic, strong) SXMineChildModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
