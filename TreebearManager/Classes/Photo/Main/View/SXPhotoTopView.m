//
//  SXPhotoTopView.m
//  TreebearManager
//
//  Created by bear on 2019/4/11.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoTopView.h"

@interface SXPhotoTopView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation SXPhotoTopView

+ (instancetype)topView{
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

#pragma mark -setter-
- (void)setCount:(NSInteger)count{
    _count = count;
    
    self.titleL.text = [NSString stringWithFormat:@"已选中%ld张照片",count];
}

#pragma mark -Event-
- (IBAction)clickCloseBtn:(UIButton *)sender {
    if (self.clickCloseBtnBlock){
        self.clickCloseBtnBlock();
    }
}


@end
