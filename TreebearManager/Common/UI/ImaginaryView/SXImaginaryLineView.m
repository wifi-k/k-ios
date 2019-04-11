//
//  SXImaginaryLineView.m
//  TreebearManager
//
//  Created by bear on 2019/2/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXImaginaryLineView.h"

@implementation SXImaginaryLineView

- (void)drawRect:(CGRect)rect { //可以通过 setNeedsDisplay 方法调用 drawRect:
    [super drawRect:rect];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线条的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 绘制线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, SXColorTextDisabled.CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 设置虚线绘制起点
    CGContextMoveToPoint(context, 3.0, self.frame.size.height/2);
    // lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复
    CGFloat lengths[] = {7,3};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths,2);
    // 绘制虚线的终点
    CGContextAddLineToPoint(context, self.frame.size.width - 3,self.frame.size.height/2);
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
}

@end
