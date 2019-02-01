//
//  SXHomeMainSectionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SXHomeMainSectionHeaderViewID = @"SXHomeMainSectionHeaderViewID";

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainSectionHeaderView : UITableViewHeaderFooterView
    
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;//标题
    
@end

NS_ASSUME_NONNULL_END
