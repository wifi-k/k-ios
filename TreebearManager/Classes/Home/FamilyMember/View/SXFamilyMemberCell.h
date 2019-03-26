//
//  SXFamilyMemberCell.h
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXFamilyMemberModel.h"

@interface SXFamilyMemberCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SXFamilyMemberModel *model;

///点击删除按钮回调
@property (nonatomic, copy) void (^clickDeleteBtnBlock)(SXFamilyMemberModel *model);

@end

