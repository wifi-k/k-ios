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

///点击备注按钮回调
@property (nonatomic, copy) void (^clickRemarkBtnBlock)(void);
    
@end

NS_ASSUME_NONNULL_END
