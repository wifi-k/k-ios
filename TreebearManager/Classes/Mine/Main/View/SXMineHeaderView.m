//
//  SXMineHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineHeaderView.h"

@interface SXMineHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *mobileL;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@end

@implementation SXMineHeaderView

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

#pragma mark -UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColor2E2E2E;
    
    self.nameL.font = SXFontBold16;
    self.mobileL.textColor = SXColorWhite;
    
    //1.1添加点击手势
    self.mobileL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMobile)];
    [self.mobileL addGestureRecognizer:tap];
    
    [self.iconBtn roundViewWithRadius:30.0f];
}

#pragma mark -Event-
- (void)clickMobile{
    if (self.clickMobileBlock) {
        self.clickMobileBlock();
    }
}

- (IBAction)clickIconBtn:(UIButton *)sender {
    if (self.clickIconBtnBlock) {
        self.clickIconBtnBlock();
    }
}

@end
