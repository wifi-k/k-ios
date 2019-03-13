//
//  SXMobileManagerCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileManagerCell.h"

@interface SXMobileManagerCell ()
@property (weak, nonatomic) IBOutlet UIView *contentBgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *mobileNameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIButton *remarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@end

@implementation SXMobileManagerCell

static NSString *SXMobileManagerCellID = @"SXMobileManagerCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXMobileManagerCellID];
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
    
    //[self.iconImageV roundViewWithRadius:30.0f];
    
    self.contentBgView.backgroundColor = SXColorClear;
    
    [self.statusBtn setTitleColor:SXColorBlue2 forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:SXColorWhite];
    self.statusBtn.backgroundColor = [UIColor whiteColor];
    self.statusBtn.layer.cornerRadius = 15;
    self.statusBtn.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.statusBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.statusBtn.layer.shadowOpacity = 0.5;
    self.statusBtn.layer.shadowRadius = 2;
    
    [self.remarkBtn setTitleColor:SXColorBlue2 forState:UIControlStateNormal];
}

#pragma mark -setter-
- (void)setModel:(SXHomeMobileModel *)model{
    _model = model;
    
    switch (model.mobileType.integerValue) {
        case 0:
            self.iconImageV.image = [UIImage imageNamed:@"img_mobile_icon"];
            break;
        case 1:
            self.iconImageV.image = [UIImage imageNamed:@"img_iphone_icon"];
            break;
        case 2:
            self.iconImageV.image = [UIImage imageNamed:@"img_android_icon"];
            break;
        default:
            self.iconImageV.image = [UIImage imageNamed:@"img_mobile_icon"];
            break;
    }
}

#pragma mark -点击事件-
- (IBAction)clickRemarkBtn:(UIButton *)sender {
    if (self.clickRemarkBtnBlock) {
        self.clickRemarkBtnBlock();
    }
}

@end
