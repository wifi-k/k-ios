//
//  SXHomeMainHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainHeaderView.h"
#import "SXImaginaryLineView.h"
#import "SXHomeMainGotoUserInfoButton.h"
#import "SXHomeMainSettingButton.h"
#import "SXHomeMainMemberButton.h"

@interface SXHomeMainHeaderView ()
@property (weak, nonatomic) IBOutlet SXImaginaryLineView *horizonDivideView;
@property (weak, nonatomic) IBOutlet UIView *verticalDivideView;
@property (weak, nonatomic) IBOutlet UIImageView *topCardBgImageView;
@property (weak, nonatomic) IBOutlet SXHomeMainMemberButton *managerBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainMemberButton *inviteMemberBtn;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageL;
@property (weak, nonatomic) IBOutlet UIView *noticeBgView;

@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *parentControlBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *healthyModeBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *switchBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *wifiSettingBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;

@property (weak, nonatomic) IBOutlet UIImageView *backupIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *backupContentView;
@property (weak, nonatomic) IBOutlet UIButton *backupBtn;
@property (weak, nonatomic) IBOutlet UIView *backupBgView;
@end

@implementation SXHomeMainHeaderView

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
    
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.topBgView.backgroundColor = [UIColor whiteColor];
    self.topBgView.layer.cornerRadius = 5;
    self.topBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.topBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.topBgView.layer.shadowOpacity = 0.5;
    self.topBgView.layer.shadowRadius = 5;
    
    [self.topCardBgImageView roundViewWithRadius:5.0f];
    
    self.horizonDivideView.backgroundColor = SXColorClear;
    self.verticalDivideView.width = 1;
    
    self.noticeBgView.backgroundColor = SXColorGray8;
    [self.noticeBgView roundViewWithRadius:5.0f];
    
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    self.backupBgView.backgroundColor = [UIColor whiteColor];
    self.backupBgView.layer.cornerRadius = 4;
    self.backupBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.backupBgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.backupBgView.layer.shadowOpacity = 0.5;
    self.backupBgView.layer.shadowRadius = 2;
    self.backupBgView.backgroundColor = SXColorWhite;
    
    self.backupContentView.textColor = SXColor666666;
    [self.backupBtn roundViewWithRadius:15.0f];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMessageBgView)];
    [self.noticeBgView addGestureRecognizer:tap];
    
    //添加标签
    UILabel *managerL = [[UILabel alloc] init];
    managerL.backgroundColor = SXColorOrange;
    managerL.textColor = SXColorWhite;
    managerL.textAlignment = NSTextAlignmentCenter;
    managerL.font = SXFont14;
    managerL.text = @"管理员";
    [managerL roundViewWithRadius:12.5f];
    [self.managerBtn addSubview:managerL];
    [managerL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 25));
        make.top.mas_equalTo(self.managerBtn.mas_top);
        make.right.mas_equalTo(self.managerBtn.mas_right);
    }];
}

#pragma mark -事件监听-
- (IBAction)clickUserInfoBtn:(SXHomeMainGotoUserInfoButton *)sender {
    if (self.clickUserInfoBtnBlock) {
        self.clickUserInfoBtnBlock();
    }
}

- (void)clickMessageBgView{
    if (self.clickMessageBgViewBlock) {
        self.clickMessageBgViewBlock();
    }
}

- (IBAction)clickSettingBtn:(SXHomeMainSettingButton *)sender {
    if (self.clickSettingBtnBlock) {
        self.clickSettingBtnBlock(sender.tag);
    }
}

- (IBAction)clickBackupBtn:(UIButton *)sender {
    if (self.clickBackupBtnBlock) {
        self.clickBackupBtnBlock();
    }
}

@end
