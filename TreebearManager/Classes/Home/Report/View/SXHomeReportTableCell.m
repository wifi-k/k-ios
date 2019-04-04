//
//  SXHomeReportTableCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportTableCell.h"

@interface SXHomeReportTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobileNameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXHomeReportTableCell

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

//初始化UI
- (void)setUpUI{
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
}

#pragma mark -setter-
- (void)setModel:(SXHomeReportModel *)model{
    _model = model;
    
    self.mobileNameL.text = model.hostName;
    self.contentL.text = model.remark;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.macIcon] placeholderImage:[UIImage imageNamed:@"img_mobile_icon"] options:SDWebImageRetryFailed];
}

@end
