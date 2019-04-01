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
    
    [self.statusBtn setTitleColor:SXColorBlue forState:UIControlStateNormal];
    [self.statusBtn setBackgroundColor:SXColorWhite];
    self.statusBtn.backgroundColor = [UIColor whiteColor];
    self.statusBtn.layer.cornerRadius = 15;
    self.statusBtn.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.statusBtn.layer.shadowOffset = CGSizeMake(0, 2);
    self.statusBtn.layer.shadowOpacity = 0.5;
    self.statusBtn.layer.shadowRadius = 2;
    
    [self.remarkBtn setTitleColor:SXColorSystemBlue forState:UIControlStateNormal];
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    self.mobileNameL.text = model.name;
    switch (model.status.integerValue) {
        case 0:
            [self.statusBtn setTitle:@"离线" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColor666666 forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"离线时间:%@",model.offTime];
            break;
        case 1:
            [self.statusBtn setTitle:@"在线" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColorBlue forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"在线时间:%@",model.onTime];
            break;
        default:
            [self.statusBtn setTitle:@"状态" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColor666666 forState:UIControlStateNormal];
            self.timeL.text = [NSString stringWithFormat:@"在线时间:%@",@"未知"];
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
