//
//  SXMineListCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineListCell.h"

@interface SXMineListCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXMineListCell

static NSString *SXMineListCellID = @"SXMineListCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXMineListCellID];
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
    
    self.bottomLineView.backgroundColor = SXColorRandom;
}

@end
