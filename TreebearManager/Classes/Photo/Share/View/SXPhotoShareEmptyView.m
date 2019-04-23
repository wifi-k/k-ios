//
//  SXPhotoShareEmptyView.m
//  TreebearManager
//
//  Created by bear on 2019/4/23.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareEmptyView.h"

@interface SXPhotoShareEmptyView ()
@property (weak, nonatomic) IBOutlet UILabel *contentL1;
@property (weak, nonatomic) IBOutlet UILabel *contentL2;

@end

@implementation SXPhotoShareEmptyView

+ (instancetype)emptyView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

//xib唤醒转代码
- (void)awakeFromNib{
    [super awakeFromNib];
    
    // 不需要跟随父控件的尺寸变化而伸缩
    //self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpUI];
 
    self.contentL1.textColor = SXColor7383A2;
    self.contentL2.textColor = SXColor7383A2;
}

- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
}

@end
