//
//  SXHealtyControlCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlCell.h"

@interface SXHealtyControlCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXHealtyControlCell

static NSString *SXHealtyControlCellID = @"SXHealtyControlCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXHealtyControlCellID];
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
    
    self.timeL.textColor = SXColor333333;
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
}

#pragma mark -setter-
- (void)setModel:(SXHealtyControlModel *)model{
    _model = model;
    
    self.timeL.text = [NSString stringWithFormat:@"%@-%@",model.startTime,model.endTime];
}

#pragma mark -event-
- (IBAction)clickEditBtn:(UIButton *)sender {
    if (self.clickEditBtnBlock) {
        self.clickEditBtnBlock(self.model);
    }
}


@end
