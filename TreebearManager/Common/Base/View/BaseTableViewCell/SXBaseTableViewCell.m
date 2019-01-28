//
//  SXBaseTableViewCell.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseTableViewCell.h"

@implementation SXBaseTableViewCell

+ (instancetype)cellFromNib:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

+ (instancetype)cellFromClass:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self);
    [tableView registerClass:self forCellReuseIdentifier:identifier];
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
