//
//  SXAdvancedOptionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAdvancedOptionCell.h"

@interface SXAdvancedOptionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXAdvancedOptionCell

static NSString *SXAdvancedOptionCellID = @"SXAdvancedOptionCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXAdvancedOptionCellID];
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

#pragma mark -初始化UI-
- (void)setUpUI{
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5;
    
    self.titleL.textColor = SXColor2B3852;
}

#pragma mark -setter-
- (void)setModel:(SXAdvancedOptionModel *)model{
    _model = model;
    
    self.titleL.text = model.title;
    self.checkImageView.hidden = !self.model.selected.boolValue;
}

@end
