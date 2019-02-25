//
//  SXHomeMessageCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMessageCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXHomeMessageModel *model;

@end

NS_ASSUME_NONNULL_END
