//
//  SXNetWallCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXPreventModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNetPreventCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///模型
@property (nonatomic, strong) SXPreventModel *model;

@end

NS_ASSUME_NONNULL_END
