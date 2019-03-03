//
//  SXHomeXiaoKiCell.h
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeXiaoKiCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

///点击修改名称回调
@property (nonatomic, copy) void (^clickUpdateNameBtnBlock)(void);
///点击解绑按钮回调
@property (nonatomic, copy) void (^clickUnbindBtnBlock)(void);
///点击升级版本回调
@property (nonatomic, copy) void (^clickUpdateVersionBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
