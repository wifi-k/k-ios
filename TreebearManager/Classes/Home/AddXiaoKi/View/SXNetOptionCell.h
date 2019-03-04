//
//  SXNetOptionCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXNetOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXNetOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///是否选中
@property (nonatomic, copy) SXNetOptionModel *model;

@end

NS_ASSUME_NONNULL_END
