//
//  SXHomeNetworkingDeviceCell.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeNetworkingDeviceCell.h"

@interface SXHomeNetworkingDeviceCell ()
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *mobileNameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIButton *remarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@end

@implementation SXHomeNetworkingDeviceCell
    
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifer = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifer owner:nil options:nil] lastObject];
    }
    return cell;
}
    
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背样式
    self.contentView.backgroundColor = SXColorWhite;
//    self.contentBgView.backgroundColor = SXColorClear;
    
    self.contentBgView.backgroundColor = [UIColor whiteColor];
    self.contentBgView.layer.cornerRadius = 5;
    self.contentBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.contentBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.contentBgView.layer.shadowOpacity = 0.3;
    self.contentBgView.layer.shadowRadius = 5;
    
    self.timeL.textColor = SXColor7383A2;
    
    [self.remarkBtn setTitleColor:SXColor47D5ED forState:UIControlStateNormal];
    [self.remarkBtn roundViewWithRadius:4.0f borderColor:SXColor47D5ED borderWidth:0.5f];
    
    [self.statusBtn setTitleColor:SXColor7383A2 forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:SXColorWhite];
    self.statusBtn.backgroundColor = [UIColor whiteColor];
    self.statusBtn.layer.cornerRadius = 15.0f;
    self.statusBtn.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.statusBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.statusBtn.layer.shadowOpacity = 0.3;
    self.statusBtn.layer.shadowRadius = 2;
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.macIcon] placeholderImage:[UIImage imageNamed:@"img_mobile_icon"] options:SDWebImageRetryFailed];
    self.mobileNameL.text = ([NSString isEmpty:model.note] ? model.name : model.note);
    switch (model.status.integerValue) {
        case 0:
            [self.statusBtn setTitle:@"离线" forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"离线时间:%@",[NSString stringWithTimestamp2:model.offTime]];
            break;
        case 1:
            [self.statusBtn setTitle:@"在线" forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"在线时间:%@",[NSString stringWithTimestamp2:model.onTime]];
            break;
        default:
            [self.statusBtn setTitle:@"状态" forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"在线时间:%@",@"未知"];
            break;
    }
}

#pragma mark -点击事件-
- (IBAction)clickRemarkBtn:(UIButton *)sender {
    if (self.clickRemarkBtnBlock) {
        self.clickRemarkBtnBlock(self.model);
    }
}
    
@end
