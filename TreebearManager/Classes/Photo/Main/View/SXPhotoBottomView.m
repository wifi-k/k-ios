//
//  SXPhotoBottomView.m
//  TreebearManager
//
//  Created by bear on 2019/4/11.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBottomView.h"
#import "SXPhotoBrowserCustomButton.h"

@interface SXPhotoBottomView ()
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *shareBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *deleteBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *backupBtn;
@property (weak, nonatomic) IBOutlet SXPhotoBrowserCustomButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXPhotoBottomView

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
    
    self.bottomBgView.backgroundColor = SXColorWhite;
    
    [self.shareBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.backupBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    [self.downloadBtn setTitleColor:SXColor2B3852 forState:UIControlStateNormal];
    
    [self.shareBtn setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [self.deleteBtn setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [self.backupBtn setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
    [self.downloadBtn setTitleColor:SXColor2B3852 forState:UIControlStateHighlighted];
}

@end
