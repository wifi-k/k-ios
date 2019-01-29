//
//  SXBaseTableViewPlainController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXBaseEmptyDataView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseTableViewPlainController : UITableViewController
@property (nonatomic, strong) SXBaseEmptyDataView *emptyDataView;
@end

NS_ASSUME_NONNULL_END
