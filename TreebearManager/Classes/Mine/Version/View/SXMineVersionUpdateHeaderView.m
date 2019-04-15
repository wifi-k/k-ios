//
//  SXMineVersionUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineVersionUpdateHeaderView.h"

@interface SXMineVersionUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *currentVersionTitleL;
@property (weak, nonatomic) IBOutlet UILabel *currentVersionL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView1;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *lastestVersionTitleL;
@property (weak, nonatomic) IBOutlet UILabel *lastestVersionL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end

@implementation SXMineVersionUpdateHeaderView

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
    
    self.currentVersionTitleL.textColor = SXColor2B3852;
    self.lastestVersionTitleL.textColor = SXColor2B3852;
    
    self.currentVersionL.textColor = SXColor7383A2;
    self.lastestVersionL.textColor = SXColor7383A2;
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    
    self.bottomLineView1.backgroundColor = SXColorDivideLine;
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView1.height = 0.5;
    self.bottomLineView2.height = 0.1;
    
    self.updateBtn.backgroundColor = SXColorWhite;
    [self.updateBtn setTitleColor:SXColor7383A2 forState:UIControlStateNormal];
    [self.updateBtn roundViewWithRadius:22.5f borderColor:SXColorDivideLine borderWidth: 1.0f];
}

#pragma mark -初始化数据-
- (void)setUpData{
    self.currentVersionL.text = [NSString stringWithFormat:@"%@",APP_VERSION];
    self.lastestVersionL.text = [NSString stringWithFormat:@"%@",APP_VERSION];
}

#pragma mark -Event-
- (IBAction)clickUpdateBtn:(UIButton *)sender {
    if (self.clickUpdaeVersionBtnBlock) {
        self.clickUpdaeVersionBtnBlock();
    }
}


@end
