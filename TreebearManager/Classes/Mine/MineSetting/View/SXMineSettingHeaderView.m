//
//  SXMineSettingHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineSettingHeaderView.h"

@interface SXMineSettingHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *currentVersionL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@end

@implementation SXMineSettingHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
    
    [self setUpData];
}

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView1.height = 0.5f;
    
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.height = 0.5f;
    
    self.currentVersionL.textColor = SXColor999999;
    
    //添加事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAboutUs)];
    [self.firstBgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUpdateVersion)];
    [self.secondBgView addGestureRecognizer:tap2];
    
    self.logoutBtn.backgroundColor = SXColorWhite;
    [self.logoutBtn setTitleColor:SXColor999999 forState:UIControlStateNormal];
    [self.logoutBtn roundViewWithRadius:22.5f borderColor:SXColorDivideLine borderWidth: 1.0f];
}

#pragma mark -初始化数据-
- (void)setUpData{
    self.currentVersionL.text = [NSString stringWithFormat:@"当前版本%@",APP_VERSION];
}

#pragma mark -Event-
- (void)clickAboutUs{
    if (self.clickAboutUsBlock) {
        self.clickAboutUsBlock();
    }
}

- (void)clickUpdateVersion{
    if (self.clickUpdateVersionBlock) {
        self.clickUpdateVersionBlock();
    }
}

- (IBAction)clickLogoutBtn:(UIButton *)sender {
    if (self.clickLogoutBtnBlock) {
        self.clickLogoutBtnBlock();
    }
}

@end
