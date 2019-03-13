//
//  SXMineListCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMineUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///模型
@property (nonatomic, strong) SXMineUserInfoModel *model;

@end

NS_ASSUME_NONNULL_END
