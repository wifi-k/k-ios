//
//  SXXiaoKiEquipmentOptionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiEquipmentOptionCell.h"

@interface SXXiaoKiEquipmentOptionCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXXiaoKiEquipmentOptionCell

static NSString *SXXiaoKiEquipmentOptionCellID = @"SXXiaoKiEquipmentOptionCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXXiaoKiEquipmentOptionCellID];
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
    self.bottomLineView.height = 0.5;
}

#pragma mark -setter-
- (void)setModel:(SXHomeXiaoKiModel *)model{
    _model = model;
    
    self.nameL.text = [NSString stringWithFormat:@"名称:%@",model.name];
}

@end
