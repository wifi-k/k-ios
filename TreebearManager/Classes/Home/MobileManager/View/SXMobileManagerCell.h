//
//  SXMobileManagerCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXHomeMobileModel.h"

@interface SXMobileManagerCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXHomeMobileModel *model;

///点击备注按钮回调
@property (nonatomic, copy) void (^clickRemarkBtnBlock)(void);

@end
