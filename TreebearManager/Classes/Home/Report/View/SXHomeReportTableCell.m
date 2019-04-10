//
//  SXHomeReportTableCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportTableCell.h"

@interface SXHomeReportTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *mobileImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobileNameL;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bottomView.backgroundColor = SXColorClear;
    
    self.timeL.font = SXFontBold16;
    
    [self.mobileImageView roundViewWithRadius:35.0f borderColor:SXColorWhite borderWidth:10.f];
    
    self.mobileNameL.textColor = SXColor333333;
    self.reportBtn.userInteractionEnabled = NO;
    [self.reportBtn setTitleColor:SXColorBlue forState:UIControlStateNormal];
    [self.reportBtn roundViewWithRadius:15.0f borderColor:SXColorBlue borderWidth:1.0f];
}

#pragma mark -setter-
- (void)setModel:(SXHomeReportModel *)model{
    _model = model;
    
    self.timeL.text = [NSString stringWithFormat:@"上周平均每日活跃时长:%@",model.totalTime];
    self.mobileNameL.text = model.hostName;
    [self.mobileImageView sd_setImageWithURL:[NSURL URLWithString:model.macIcon] placeholderImage:[UIImage imageNamed:@"img_android_icon"] options:SDWebImageRetryFailed];
}

@end
