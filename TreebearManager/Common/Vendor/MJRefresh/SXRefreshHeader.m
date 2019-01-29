//
//  SXRefreshHeader.m
//  TreebearManager
//
//  Created by bear on 2019/1/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRefreshHeader.h"

@implementation SXRefreshHeader

- (void)prepare{
    [super prepare];
    
    NSArray *imageArray = @[[UIImage imageNamed:@"logo_refresh_1"],[UIImage imageNamed:@"logo_refresh_2"],[UIImage imageNamed:@"logo_refresh_3"],[UIImage imageNamed:@"logo_refresh_4"],[UIImage imageNamed:@"logo_refresh_5"],[UIImage imageNamed:@"logo_refresh_6"],[UIImage imageNamed:@"logo_refresh_7"],[UIImage imageNamed:@"logo_refresh_8"],[UIImage imageNamed:@"logo_refresh_9"],[UIImage imageNamed:@"logo_refresh_10"],[UIImage imageNamed:@"logo_refresh_11"],[UIImage imageNamed:@"logo_refresh_12"]];
    [self setImages:imageArray duration:0.5 forState:MJRefreshStateRefreshing];
    
    NSArray *idleImageArray = @[[UIImage imageNamed:@"logo_refresh_1"]];
    [self setImages:idleImageArray forState:MJRefreshStateIdle];
    [self setImages:idleImageArray forState:MJRefreshStatePulling];
    [self setImages:idleImageArray forState:MJRefreshStateWillRefresh];
    
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = YES;
}
    
    
- (void)placeSubviews{
    [super placeSubviews];
    
    self.mj_h = 60;
    
    self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat gifWidth = 40;
    
    self.gifView.mj_w = gifWidth;
    self.gifView.mj_h = gifWidth;
    self.gifView.mj_x = self.kwidth/2 - gifWidth/2;
    self.gifView.mj_y = 10;
}
    
@end
