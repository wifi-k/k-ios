//
//  SXHomeXiaoKiCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeXiaoKiCell.h"

@interface SXHomeXiaoKiCell ()

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
    
    [self.statusBtn roundViewWithRadius:4.0f];
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5f;
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    [self.updateNameBtn roundViewWithRadius:4.0f borderColor:SXColor333333 borderWidth:1.0f];
    [self.untyingXiaoKiBtn roundViewWithRadius:4.0f borderColor:SXColor333333 borderWidth:1.0f];
    [self.upgradeVersionBtn roundViewWithRadius:4.0f borderColor:SXColor333333 borderWidth:1.0f];
}

#pragma mark -setter-
- (void)setModel:(SXHomeXiaoKiModel *)model{
    _model = model;
    
    
}

#pragma mark -点击事件-
- (IBAction)updateNameBtn:(UIButton *)sender {
    if (self.clickUpdateNameBtnBlock) {
        self.clickUpdateNameBtnBlock();
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
