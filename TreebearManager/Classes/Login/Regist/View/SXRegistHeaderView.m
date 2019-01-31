//
//  SXRegistHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistHeaderView.h"

@interface SXRegistHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineVH;
    
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV2;
    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineV2H;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation SXRegistHeaderView

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
    self.titleL.font = SXFontBold20;
}

#pragma mark -按钮点击事件-
- (IBAction)clickRegistBtn:(UIButton *)sender {
    [MBProgressHUD showMessageToWindow:@"注册成功!"];
}
    
@end
