//
//  SXNetOptionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetOptionCell.h"

@interface SXNetOptionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXNetOptionCell

static NSString *SXNetOptionCellID = @"SXNetOptionCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXNetOptionCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    
    self.titleL.textColor = SXColor666666;
}

#pragma mark -setter-
- (void)setModel:(SXNetOptionModel *)model{
    _model = model;
    
    self.titleL.text = model.title;
    self.checkImageView.hidden = !self.model.selected.boolValue;
}

@end
