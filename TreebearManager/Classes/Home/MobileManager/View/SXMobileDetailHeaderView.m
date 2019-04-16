//
//  SXMobileDetailHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileDetailHeaderView.h"
#import "SXInputAlertView.h"
#import "SXWifiSettingNetTool.h"
#import "SXNotificationCenterTool.h"

@interface SXMobileDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *naviTitleL;
@property (weak, nonatomic) IBOutlet UIImageView *topIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UILabel *mobileInfoTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerFirstBgView;

@property (weak, nonatomic) IBOutlet UISwitch *careSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *childCareTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerSecondBgView;

@property (weak, nonatomic) IBOutlet UISwitch *remindSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *remindTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerThirdBgView;

@property (weak, nonatomic) IBOutlet UISwitch *blackSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *blacklistTitleL;
@property (weak, nonatomic) IBOutlet UIView *centerFourthBgView;
@property (weak, nonatomic) IBOutlet UIView *centerBgView;

@property (weak, nonatomic) IBOutlet UISwitch *limitSwitchBtn;
@property (weak, nonatomic) IBOutlet UILabel *limitTitleL;
@property (weak, nonatomic) IBOutlet UIView *bottomFirstBgView;

@property (weak, nonatomic) IBOutlet UILabel *upTitleL;
@property (weak, nonatomic) IBOutlet UISlider *upSlider;
@property (weak, nonatomic) IBOutlet UILabel *upL;
@property (weak, nonatomic) IBOutlet UIView *bottomSecondBgView;

@property (weak, nonatomic) IBOutlet UILabel *downTitleL;
@property (weak, nonatomic) IBOutlet UISlider *downSlider;
@property (weak, nonatomic) IBOutlet UILabel *downL;
@property (weak, nonatomic) IBOutlet UIView *bottomThirdBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXMobileDetailHeaderView

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
    
    self.naviTitleL.font = SXFontBold18;
    self.topBgView.backgroundColor = SXColorWhite;
    
    self.mobileInfoTitleL.textColor = SXColor2B3852;
    self.childCareTitleL.textColor = SXColor2B3852;
    self.remindTitleL.textColor = SXColor2B3852;
    self.blacklistTitleL.textColor = SXColor2B3852;
    
    self.mobileInfoTitleL.font = SXFontBold17;
    self.childCareTitleL.font = SXFontBold17;
    self.remindTitleL.font = SXFontBold17;
    self.blacklistTitleL.font = SXFontBold17;
    
    self.centerBgView.backgroundColor = [UIColor whiteColor];
    self.centerBgView.layer.cornerRadius = 5;
    self.centerBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.centerBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.centerBgView.layer.shadowOpacity = 0.5;
    self.centerBgView.layer.shadowRadius = 5;
    
    //1.1添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCenterFirstBgView)];
    [self.centerFirstBgView addGestureRecognizer:tap];
    
    self.bottomBgView.backgroundColor = [UIColor whiteColor];
    self.bottomBgView.layer.cornerRadius = 5;
    self.bottomBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.bottomBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.bottomBgView.layer.shadowOpacity = 0.5;
    self.bottomBgView.layer.shadowRadius = 5;
    self.bottomBgView.hidden = YES;
    
    
    //缩放
    //    self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.careSwitchBtn.onTintColor = SXColorBlue2;
    self.remindSwitchBtn.onTintColor = SXColorBlue2;
    self.blackSwitchBtn.onTintColor = SXColorBlue2;
    self.limitSwitchBtn.onTintColor = SXColorBlue2;
    
    self.upSlider.tintColor = SXColorBlue2;
    self.downSlider.tintColor = SXColorBlue2;
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    [self.topIconImageView sd_setImageWithURL:[NSURL URLWithString:model.macIcon] placeholderImage:[UIImage imageNamed:@"img_android_icon"] options:SDWebImageRetryFailed];
    self.nameL.text = ([NSString isEmpty:model.note] ? model.name : model.note);
    switch (model.status.integerValue) {
        case 0://离线
            self.statusL.text = [NSString stringWithFormat:@"%@ 离线",[NSString stringWithTimestamp2:model.offTime]];
            break;
        case 1://在线
            self.statusL.text = [NSString stringWithFormat:@"%@ 在线",[NSString stringWithTimestamp2:model.onTime]];
            break;
        default:
            break;
    }
    self.blackSwitchBtn.on = !model.isBlock.boolValue;
    self.careSwitchBtn.on = model.isRecord.boolValue;
    self.remindSwitchBtn.on = model.isOnline.boolValue;
}

#pragma mark -点击事件-
- (IBAction)clickBackBtn:(UIButton *)sender {
    if (self.clickBackBtnBlock) {
        self.clickBackBtnBlock();
    }
}

- (void)clickCenterFirstBgView{
    if (self.clickCenterFirstBgViewBlock) {
        self.clickCenterFirstBgViewBlock();
    }
}

- (IBAction)clickEditBtn:(UIButton *)sender {
    WS(weakSelf);
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        SXMobilePageParam *param = [SXMobilePageParam param];
        param.nodeId = self.model.nodeId;
        param.mac = self.model.mac;
        param.note = text;
        [weakSelf userDodeDeviceSetDataWithParam:param];
    };
    [nameAlertView alert];
}

#pragma mark -Switch Event-
- (IBAction)clickCareSwitchBtn:(UISwitch *)sender {
    SXMobilePageParam *param = [SXMobilePageParam param];
    param.nodeId = self.model.nodeId;
    param.mac = self.model.mac;
    param.note = self.model.note;
    param.isRecord = @(sender.isOn);
    WS(weakSelf);
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        //模型赋值
        weakSelf.model.isRecord = param.isRecord;
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

- (IBAction)clickRemindSwitchBtn:(UISwitch *)sender {
    SXMobilePageParam *param = [SXMobilePageParam param];
    param.nodeId = self.model.nodeId;
    param.mac = self.model.mac;
    param.note = self.model.note;
    param.isOnline = @(sender.isOn);
    WS(weakSelf);
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        //模型赋值
        weakSelf.model.isOnline = param.isOnline;
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

- (IBAction)clickBlackSwitchBtn:(UISwitch *)sender {
    SXMobilePageParam *param = [SXMobilePageParam param];
    param.nodeId = self.model.nodeId;
    param.mac = self.model.mac;
    param.note = self.model.note;
    param.isBlock = @(!sender.isOn);
    WS(weakSelf);
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        //模型赋值
        weakSelf.model.isBlock = param.isBlock;
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

#pragma mark -修改设备信息-
- (void)userDodeDeviceSetDataWithParam:(SXMobilePageParam *)param{
    WS(weakSelf);
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        weakSelf.nameL.text = param.note;
        weakSelf.model.note = param.note;
        //通知刷新
        [SXNotificationCenterTool postNotificationDeviceUpdateRemarkSuccess];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

@end
