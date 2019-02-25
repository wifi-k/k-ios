//
//  SXHomeMessageCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMessageCell.h"

@interface SXHomeMessageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXHomeMessageCell

static NSString *SXHomeMessageCellID = @"SXHomeMessageCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXHomeMessageCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    self.titleL.textColor = SXColor333333;
    self.contentL.textColor = SXColor999999;
    self.timeL.textColor = SXColor999999;
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
}

- (void)setModel:(SXHomeMessageModel *)model{
    _model = model;
    
    self.titleL.text = model.title;
    self.contentL.text = model.content;
    self.timeL.text = @"2018-12-14 12:00";
}

@end
