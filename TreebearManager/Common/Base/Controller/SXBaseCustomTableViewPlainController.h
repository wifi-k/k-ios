//
//  SXBaseCustomTableViewPlainController.h
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXBaseEmptyDataView.h"

@interface SXBaseCustomTableViewPlainController : UIViewController
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) SXBaseEmptyDataView *emptyDataView;
@end
