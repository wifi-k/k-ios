//
//  SXHomeNetworkingDeviceCell.h
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeMobileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeNetworkingDeviceCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXHomeMobileModel *model;
    
@end

NS_ASSUME_NONNULL_END
