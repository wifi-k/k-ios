//
//  SXMobileInfoHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileInfoHeaderView.h"

@interface SXMobileInfoHeaderView ()


@property (weak, nonatomic) IBOutlet UILabel *vendorTitleL;
@property (weak, nonatomic) IBOutlet UILabel *vendorL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView2;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UILabel *macTitleL;
@property (weak, nonatomic) IBOutlet UILabel *macL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView3;
@property (weak, nonatomic) IBOutlet UIView *thirdBgView;

@property (weak, nonatomic) IBOutlet UILabel *ipTitleL;
@property (weak, nonatomic) IBOutlet UILabel *ipL;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView4;
@property (weak, nonatomic) IBOutlet UIView *fourthBgView;

@end

@implementation SXMobileInfoHeaderView

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
    
    self.secondBgView.backgroundColor = SXColorWhite;
    self.thirdBgView.backgroundColor = SXColorWhite;
    self.fourthBgView.backgroundColor = SXColorWhite;
    
    self.bottomLineView2.backgroundColor = SXColorDivideLine;
    self.bottomLineView3.backgroundColor = SXColorDivideLine;
    self.bottomLineView4.backgroundColor = SXColorDivideLine;
    
    self.bottomLineView2.height = 0.5f;
    self.bottomLineView3.height = 0.5f;
    self.bottomLineView4.height = 0.5f;
    
    self.vendorTitleL.textColor = SXColor2B3852;
    self.macTitleL.textColor = SXColor2B3852;
    self.ipTitleL.textColor = SXColor2B3852;
    
    self.vendorL.textColor = SXColor7383A2;
    self.macL.textColor = SXColor7383A2;
    self.ipL.textColor = SXColor7383A2;
}

#pragma mark -setter-
- (void)setModel:(SXMobileManagerModel *)model{
    _model = model;
    
    self.vendorL.text = model.macVendor;
    self.macL.text = model.mac;
    self.ipL.text = model.mac;
}

@end
