//
//  SXDeviceControlCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenDeviceOptionCell.h"

@interface SXForbiddenDeviceOptionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXForbiddenDeviceOptionCell

static NSString *SXDeviceControlCellID = @"SXDeviceControlCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXDeviceControlCellID];
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
    self.contentView.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    
    self.deviceNameL.textColor = SXColor2B3852;
    self.timeL.textColor = SXColor7383A2;
    
    //缩放
    //    self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColor37EDA3;
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    self.deviceNameL.text = model.name;
    switch (model.status.integerValue) {
        case 0:
            self.timeL.text = [NSString stringWithFormat:@"离线时间:%@",[NSString stringWithTimestamp22:model.offTime]];
            break;
        case 1:
            self.timeL.text = [NSString stringWithFormat:@"上线时间:%@",[NSString stringWithTimestamp22:model.onTime]];
            break;
        default:
            self.timeL.text = [NSString stringWithFormat:@"上线时间:%@",@"未知"];
            break;
    }
    self.switchBtn.on = model.isBlock.boolValue;
}

#pragma mark -Event-
- (IBAction)clickSwitchBtn:(UISwitch *)sender {
    NSNumber *isBlock = (sender.isOn?@1:@0);
    self.model.isBlock = isBlock;
}

@end
