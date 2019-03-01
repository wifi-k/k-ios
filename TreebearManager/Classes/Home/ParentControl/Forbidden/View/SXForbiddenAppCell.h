//
//  SXForbiddenAppCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///禁用方案名称
@property (nonatomic, copy) NSString *title;

///点击编辑按钮回调
@property (nonatomic, copy) void (^clickEditBtnBlock)(void);
///点击删除按钮回调
@property (nonatomic, copy) void (^clickDeleteBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
