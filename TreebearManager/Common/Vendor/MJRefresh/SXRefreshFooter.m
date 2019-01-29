//
//  SXRefreshFooter.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRefreshFooter.h"

@interface SXRefreshFooter ()
@property (nonatomic, weak) UIView *noMoreDataView;
@end

@implementation SXRefreshFooter

- (void)prepare{
    [super prepare];
}
    
- (void)placeSubviews{
    [super placeSubviews];
    if (self.state == MJRefreshStateNoMoreData) {
        self.stateLabel.text = @"";
        if (!self.noMoreDataView) {
            UIView *noMoreDataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
            noMoreDataView.backgroundColor = [UIColor clearColor];
            noMoreDataView.kcenterY = self.kheight/2;
            [self addSubview:noMoreDataView];
            self.noMoreDataView = noMoreDataView;
            
            UILabel *titleL = [[UILabel alloc]initWithFrame:self.noMoreDataView.bounds];
            titleL.textAlignment = NSTextAlignmentCenter;
            titleL.text = @"我是有底线的";
            titleL.font = SXFont(13);
            titleL.textColor = UIColor.grayColor;
            [self.noMoreDataView addSubview:titleL];
            
            UIView *leftLine = [[UIView alloc]init];
            leftLine.backgroundColor = SXColorGray4;
            [self.noMoreDataView addSubview:leftLine];
            
            UIView *rightLine = [[UIView alloc]init];
            rightLine.backgroundColor = SXColorGray4;
            [self.noMoreDataView addSubview:rightLine];
            
            [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(15);
                make.right.equalTo(self.mas_centerX).offset(-50);
                make.height.equalTo(@0.5);
                make.centerY.mas_equalTo(self.noMoreDataView.mas_centerY);
            }];
            
            [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-15);
                make.left.equalTo(self.mas_centerX).offset(50);
                make.height.equalTo(@0.5);
                make.centerY.mas_equalTo(self.noMoreDataView.mas_centerY);
            }];
        }
    }else{
        if (self.noMoreDataView) {
            [self.noMoreDataView removeFromSuperview];
        }
    }
}

    
@end
