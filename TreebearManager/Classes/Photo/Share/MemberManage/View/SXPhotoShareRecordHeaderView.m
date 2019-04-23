//
//  SXPhotoShareRecordHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/4/23.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareRecordHeaderView.h"

@interface SXPhotoShareRecordHeaderView ()

@end

@implementation SXPhotoShareRecordHeaderView

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

- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
}

@end
