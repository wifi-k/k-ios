//
//  SXMineListCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineListCell.h"

@interface SXMineListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
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
    
    self.nameL.textColor = SXColor2B3852;
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.iconImageView.contentMode = UIViewContentModeCenter;
}

- (void)setModel:(SXMineUserInfoModel *)model{
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:model.avatar];
    self.nameL.text = model.name;
}

@end
