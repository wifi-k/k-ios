//
//  SXLoginMainHeaderView.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginMainHeaderView.h"

@interface SXLoginMainHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation SXLoginMainHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
}

- (void)setUpUI{
    
    [self.loginBtn setBackgroundColor:SXColorBtnHighlight forState:UIControlStateHighlighted];
    [self.loginBtn setBackgroundColor:SXColorOrange forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:SXColorGray5 forState:UIControlStateDisabled];
}

- (IBAction)clickLoginBtn:(UIButton *)sender {
    if (self.clickLoginBtnBlock) {
        self.clickLoginBtnBlock();
    }
}

- (IBAction)clickForgetBtn:(UIButton *)sender {
    if (self.clickRegistBtnBlock) {
        self.clickRegistBtnBlock();
    }
}

@end
