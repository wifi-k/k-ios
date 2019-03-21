//
//  SXNickNameUpdateHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNickNameUpdateHeaderView.h"

@interface SXNickNameUpdateHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@end

@implementation SXNickNameUpdateHeaderView

#pragma mark -getter-
- (SXMineUserInfoParam *)param{
    if (_param == nil) {
        _param = [SXMineUserInfoParam param];
    }
    return _param;
}

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
    
    self.backgroundColor = SXColorWhite;
    
    self.firstBgView.backgroundColor = SXColorF6F7FB;
    
    [self.nickTextField becomeFirstResponder];
}

- (void)setUpData{
    self.nickTextField.text = SXPersonInfoModel.sharedSXPersonInfoModel.userInfo.name;
}

#pragma mark -Event-
- (IBAction)editingNickTextField:(UITextField *)sender {
    DLog(@"sender:%@",sender.text);
    self.param.name = sender.text.filterSpace;
}

@end
