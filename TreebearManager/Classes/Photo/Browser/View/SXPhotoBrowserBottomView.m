//
//  SXPhotoBrowserBottomView.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserBottomView.h"
#import "SXPhotoBrowserCustomButton.h"

@interface SXPhotoBrowserBottomView ()
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *shareBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *deleteBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *backupBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *downloadBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation SXPhotoBrowserBottomView

+ (instancetype)bottomView{
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
    
    self.bottomView.backgroundColor = SXColorBlack;
    
    [self.shareBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
    [self.backupBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
    [self.downloadBtn setTitleColor:SXColorWhite forState:UIControlStateNormal];
    
    [self.shareBtn setTitleColor:SXColorWhite forState:UIControlStateHighlighted];
    [self.deleteBtn setTitleColor:SXColorWhite forState:UIControlStateHighlighted];
    [self.backupBtn setTitleColor:SXColorWhite forState:UIControlStateHighlighted];
    [self.downloadBtn setTitleColor:SXColorWhite forState:UIControlStateHighlighted];
}

- (IBAction)clickOptionBtn:(UIButton *)sender {
    if (self.clickOptionBtnBlock) {
        self.clickOptionBtnBlock(sender.tag);
    }
}


@end
