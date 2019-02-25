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

@interface SXHomeMainHeaderView ()
@property (weak, nonatomic) IBOutlet SXImaginaryLineView *horizonDivideView;
@property (weak, nonatomic) IBOutlet UIView *verticalDivideView;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageL;
@property (weak, nonatomic) IBOutlet UIView *noticeBgView;

@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *parentControlBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *healthyModeBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *switchBtn;
@property (weak, nonatomic) IBOutlet SXHomeMainSettingButton *wifiSettingBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
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
    self.topBgView.layer.cornerRadius = 6;
    self.topBgView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.topBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.topBgView.layer.shadowOpacity = 0.5;
    self.topBgView.layer.shadowRadius = 5;
    
    self.horizonDivideView.backgroundColor = SXColorClear;
    self.verticalDivideView.width = 1;
    
    self.noticeBgView.backgroundColor = SXColorGray8;
    [self.noticeBgView roundViewWithRadius:5.0f];
    
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMessageBgView)];
    [self.noticeBgView addGestureRecognizer:tap];
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

@end
