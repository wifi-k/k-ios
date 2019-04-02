//
//  SXDeviceControlCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXMobileManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenDeviceOptionCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXMobileManagerModel *model;

@end

NS_ASSUME_NONNULL_END
