//
//  SXHomeMainSectionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeMainSectionHeaderView : UITableViewHeaderFooterView
    
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

- (void)totalOnLineCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
