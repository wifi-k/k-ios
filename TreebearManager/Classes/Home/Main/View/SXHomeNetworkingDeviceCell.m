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
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@end

@implementation SXHomeNetworkingDeviceCell

static NSString *ID = @"SXHomeNetworkingDeviceCellID";
    
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    
    self.iconImageV.backgroundColor = SXColorRandom;
    [self.iconImageV roundViewWithRadius:30.0f];
    
    self.contentBgView.backgroundColor = SXColorClear;
    
    [self.statusBtn setTitleColor:SXColorBlue2 forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:SXColorWhite];
    self.statusBtn.backgroundColor = [UIColor whiteColor];
    self.statusBtn.layer.cornerRadius = 15;
    self.statusBtn.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.statusBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.statusBtn.layer.shadowOpacity = 0.5;
    self.statusBtn.layer.shadowRadius = 2;
}
    
@end
