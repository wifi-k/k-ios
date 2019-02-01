//
//  SXHomeNetworkingDeviceCell.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeNetworkingDeviceCell.h"

@implementation SXHomeNetworkingDeviceCell

static NSString *ID = @"SXHomeNetworkingDeviceCellID";
    
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置背样式
    self.contentView.backgroundColor = SXColorWhite;
    
    [self setUpUI];
}
    
    //初始化UI
- (void)setUpUI{
    
}
    
@end
