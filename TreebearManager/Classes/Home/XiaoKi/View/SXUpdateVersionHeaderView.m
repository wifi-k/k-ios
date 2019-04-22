//
//  SXUpdateVersionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUpdateVersionHeaderView.h"

@interface SXUpdateVersionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *naviTitleL;

@property (weak, nonatomic) IBOutlet UILabel *ssidTitleL;
@property (weak, nonatomic) IBOutlet UILabel *currentVersionTitleL;
@property (weak, nonatomic) IBOutlet UILabel *latestVersionTitleL;

@property (weak, nonatomic) IBOutlet UILabel *ssidL;
@property (weak, nonatomic) IBOutlet UILabel *currentVersionL;
@property (weak, nonatomic) IBOutlet UILabel *latestVersionL;

@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@end


@implementation SXUpdateVersionHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.naviTitleL.font = SXFontBold17;
    
    self.ssidTitleL.textColor = SXColor7383A2;
    self.currentVersionTitleL.textColor = SXColor7383A2;
    self.latestVersionTitleL.textColor = SXColor7383A2;
    
    self.ssidL.textColor = SXColor2B3852;
    self.currentVersionL.textColor = SXColor2B3852;
    self.latestVersionL.textColor = SXColor2B3852;
    
    [self.statusBtn roundViewWithRadius:4.0f];
    
    [self.updateBtn roundViewWithRadius:22.5f borderColor:SXColorEBEEF2 borderWidth:1.0f];
    [self.updateBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
}

#pragma mark -setter-
- (void)setModel:(SXHomeXiaoKiModel *)model{
    _model = model;
    
    self.naviTitleL.text = model.name;
    self.ssidL.text = model.nodeId;
    self.currentVersionL.text = model.firmware;
    if ([NSString isEmpty:model.firmwareUpgrade]) {
        self.latestVersionL.text = model.firmware;
    } else {
        self.latestVersionL.text = model.firmwareUpgrade;
    }
    
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
- (IBAction)clickUpdateBtn:(UIButton *)sender {
    if (self.clickUpdateBtnBlock) {
        self.clickUpdateBtnBlock();
    }
}

@end
