//
//  SXTimeControlAddCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXTimeControlAddCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(void);
///点击删除按钮回调
@property (nonatomic, copy) void (^clickDeleteBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
