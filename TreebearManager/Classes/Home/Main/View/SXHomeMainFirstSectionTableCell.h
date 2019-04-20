//
//  SXHomeMainFirstSectionTableCell.h
//  TreebearManager
//
//  Created by bear on 2019/4/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainFirstSectionTableCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///手机数据
@property (nonatomic, strong) NSMutableArray *mobileArray;
///在线数量
@property (nonatomic, assign) NSInteger total;

@end

NS_ASSUME_NONNULL_END
