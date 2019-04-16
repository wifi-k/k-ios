//
//  SXNetWallCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetPreventCell.h"
#import "SXWifiSettingNetTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXNetPreventCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXNetPreventCell

static NSString *SXNetWallCellID = @"SXNetWallCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXNetWallCellID];
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
    self.bottomLineView.height = 0.5;
    
    //缩放
    //self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColorBlue2;
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    self.nameL.text = ([NSString isEmpty:model.note] ? model.name : model.note);
    switch (model.status.integerValue) {
        case 0:
            self.statusL.text = [NSString stringWithFormat:@"离线时间:%@",model.offTime];
            break;
        case 1:
            self.statusL.text = [NSString stringWithFormat:@"在线时间:%@",model.onTime];
            break;
        default:
            self.statusL.text = [NSString stringWithFormat:@"在线时间:%@",@"未知"];
            break;
    }
    self.switchBtn.on = model.isBlock.boolValue;
}

#pragma mark -Event-
- (IBAction)clickSwitchBtn:(UISwitch *)sender {
    WS(weakSelf);
    SXPreventPageParam *param = [SXPreventPageParam param];
    param.nodeId = self.model.nodeId;
    param.mac = self.model.mac;
    param.note = self.model.note;
    NSNumber *isBlock = (sender.isOn? @1:@0);
    param.isBlock = isBlock;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        //weakSelf.switchBtn.on = !param.isBlock.boolValue;
        weakSelf.model.isBlock = param.isBlock;
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{        
            [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        });
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        sender.on = !sender.isOn;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

@end
