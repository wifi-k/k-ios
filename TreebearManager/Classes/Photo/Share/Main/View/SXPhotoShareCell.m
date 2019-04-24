//
//  SXPhotoShareCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareCell.h"

@implementation SXPhotoShareCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -UI-
- (void)setUpUI{
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
