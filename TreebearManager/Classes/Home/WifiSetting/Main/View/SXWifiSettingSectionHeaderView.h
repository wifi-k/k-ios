//
//  SXWifiSettingSectionHeaderView.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *SXWifiSettingSectionHeaderViewID = @"SXWifiSettingSectionHeaderViewID";

@interface SXWifiSettingSectionHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
