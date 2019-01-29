//
//  SXEmptyDataEventView.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXEmptyDataEventView.h"

@interface SXEmptyDataEventView ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
    
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidth;
    
    @property (nonatomic, copy) void (^btnBlock)(void);//block变量
@end

@implementation SXEmptyDataEventView

+ (instancetype)tipsViewWithTopImageName:(NSString *)imageName content:(NSString *)content  btnText:(NSString *)btnText btnBlock:(void (^)(void))btnBlock{
    SXEmptyDataEventView *tipsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    if (imageName.length) {
        UIImage *topImg = [UIImage imageNamed:imageName];
        if (topImg != nil) {
            tipsView.topImageV.image = topImg;
            CGSize imageSize = topImg.size;
            tipsView.imgHeight.constant = imageSize.height;
            tipsView.imgWidth.constant = imageSize.width;
        }
    }
    if (content.length) {
        tipsView.titleL.text = content;
    }
    if (btnText.length) {
        NSString *confirmStr = [NSString stringWithFormat:@"    %@    ",btnText];
        [tipsView.confirmBtn setTitle:confirmStr forState:UIControlStateNormal];
    }
    if (btnBlock) {
        tipsView.btnBlock = btnBlock;
    }
    return tipsView;
}
    
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.topImageV.contentMode = UIViewContentModeCenter;
    self.titleL.textColor = [UIColor hex:@"#a8b3d5"];
    
    [self.confirmBtn roundViewWithRadius:4.0f];
    [self.confirmBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBlue forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundColor:SXColorBtnDisabled forState:UIControlStateDisabled];
}
    
#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

@end
