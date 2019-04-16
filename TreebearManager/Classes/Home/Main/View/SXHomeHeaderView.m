//
//  SXHomeHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeHeaderView.h"
#import "SXHomeFamilyCodeButton.h"

@interface SXHomeHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UILabel *bindingDeviceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@property (weak, nonatomic) IBOutlet UILabel *addFamilyCodeL;
@property (weak, nonatomic) IBOutlet UILabel *addContentL;
@property (weak, nonatomic) IBOutlet UIView *familyCodeBgView;

@property (weak, nonatomic) IBOutlet UILabel *productL;
@property (weak, nonatomic) IBOutlet UIButton *productBtn;

@end

@implementation SXHomeHeaderView

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

    //1.家庭码背景视图
    //self.familyCodeBgView.layer.masksToBounds=YES;这行去掉
    self.familyCodeBgView.backgroundColor = [UIColor whiteColor];
    self.familyCodeBgView.layer.cornerRadius = 8;
    self.familyCodeBgView.layer.shadowColor = [UIColor colorWithColor:UIColor.lightGrayColor alpha:0.5].CGColor;
    self.familyCodeBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.familyCodeBgView.layer.shadowOpacity = 0.5;
    self.familyCodeBgView.layer.shadowRadius = 5;
    
    self.titleL.font = SXFontBold20;
    self.titleL.textColor = SXColorWhite;
    self.topImageV.backgroundColor = SXColorWhite;
    
    self.bindingDeviceL.textColor = SXColorWhite;
    self.bindingDeviceL.font = SXFontBold22;
    
    self.productL.font = SXFontBold20;
    self.productL.textColor = SXColor2B3852;
    self.addContentL.textColor = SXColor2B3852;
    self.addFamilyCodeL.font = SXFontBold20;
    self.addFamilyCodeL.textColor = SXColor2B3852;
    
    if (IPHONE_X) {
        self.topMargin.constant = 55.0f;
    } else {
        self.topMargin.constant = 55.0f - 20;
    }
}

#pragma mark -事件监听-
- (IBAction)clickBindingBtn:(UIButton *)sender {
    if (self.clickBindingBtnBlock) {
        self.clickBindingBtnBlock();
    }
}

- (IBAction)clickFamilyCodeBtn:(SXHomeFamilyCodeButton *)sender {
    if (self.clickFamilyCodeBtnBlock) {
        self.clickFamilyCodeBtnBlock();
    }
}

- (IBAction)clickProductBtn:(UIButton *)sender {
    if (self.clickProductBtnBlock) {
        self.clickProductBtnBlock();
    }
}

@end
