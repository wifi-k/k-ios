//
//  SXHomeMainSectionHeaderView2.h
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SXHomeMainSectionHeaderView2ID = @"SXHomeMainSectionHeaderView2ID";

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainSectionHeaderView2 : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;//标题

@end

NS_ASSUME_NONNULL_END
