//
//  SXHomeMainReportCell.h
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeReportModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainReportCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXHomeReportModel *model;

@end

NS_ASSUME_NONNULL_END
