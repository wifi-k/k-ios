//
//  SXHomeXiaoKiCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeXiaoKiCell.h"

@interface SXHomeXiaoKiCell ()
@property (weak, nonatomic) IBOutlet UILabel *deviceNameL;
@property (weak, nonatomic) IBOutlet UILabel *ssidTitleL;
@property (weak, nonatomic) IBOutlet UILabel *ssidL;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (weak, nonatomic) IBOutlet UIButton *updateNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *untyingXiaoKiBtn;
@property (weak, nonatomic) IBOutlet UIButton *upgradeVersionBtn;
@end

@implementation SXHomeXiaoKiCell

static NSString *SXHomeXiaoKiCellID = @"SXHomeXiaoKiCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXHomeXiaoKiCellID];
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
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    
    self.deviceNameL.font = SXFontBold17;
    self.ssidTitleL.textColor = SXColor7383A2;
    self.ssidL.textColor = SXColor2B3852;
    
    self.deviceNameL.font = SXFontBold17;
    
    [self.statusBtn roundViewWithRadius:4.0f];
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    [self.updateNameBtn roundViewWithRadius:4.0f borderColor:SXColor7383A2 borderWidth:1.0f];
    [self.untyingXiaoKiBtn roundViewWithRadius:4.0f borderColor:SXColor7383A2 borderWidth:1.0f];
    [self.upgradeVersionBtn roundViewWithRadius:4.0f borderColor:SXColor7383A2 borderWidth:1.0f];
    
    [self.updateNameBtn setTitleColor:SXColor7383A2 forState:UIControlStateNormal];
    [self.untyingXiaoKiBtn setTitleColor:SXColor7383A2 forState:UIControlStateNormal];
    [self.upgradeVersionBtn setTitleColor:SXColor7383A2 forState:UIControlStateNormal];
}

#pragma mark -setter-
- (void)setModel:(SXHomeXiaoKiModel *)model{
    _model = model;
    
    self.deviceNameL.text = [NSString stringWithFormat:@"名称:%@",model.name];
    self.ssidL.text = model.nodeId;
    switch (model.status.integerValue) {
        case 0:
            [self.statusBtn setTitle:@"离线" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
            [self.statusBtn setBackgroundColor:SXColorF6F7FB forState:UIControlStateNormal];
            break;
        case 1:
            [self.statusBtn setTitle:@"在线" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"img_button_bg_small"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.statusBtn setTitle:@"警告" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
            [self.statusBtn setBackgroundColor:SXColorF6F7FB forState:UIControlStateNormal];
            break;
        case 3:
            [self.statusBtn setTitle:@"未知" forState:UIControlStateNormal];
            [self.statusBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
            [self.statusBtn setBackgroundColor:SXColorF6F7FB forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark -点击事件-
- (IBAction)updateNameBtn:(UIButton *)sender {
    if (self.clickUpdateNameBtnBlock) {
        self.clickUpdateNameBtnBlock(self.model);
    }
}

- (IBAction)clickUnbindBtn:(UIButton *)sender {
    if (self.clickUnbindBtnBlock) {
        self.clickUnbindBtnBlock(self.model);
    }
}

- (IBAction)updateVersionBtn:(UIButton *)sender {
    if (self.clickUpdateVersionBtnBlock) {
        self.clickUpdateVersionBtnBlock(self.model);
    }
}

@end
