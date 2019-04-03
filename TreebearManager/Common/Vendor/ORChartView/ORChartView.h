//
//  ORChartView.h
//  ORChartView
//
//  Created by 欧阳荣 on 2017/9/7.
//  Copyright © 2017年 欧阳荣. All rights reserved.
//  https://github.com/SunriseOYR/ORChartView

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChatViewStyleSingleCurve = 0, //曲线
    ChatViewStyleSingleBroken,    //折线
    ChatViewStyleMatrixCurve,     //网格曲线
    ChatViewStyleMatrixBroken     //网格折线
} ChatViewStyle;

@interface ORChartView : UIView

/**
 * countY y轴 递增值的个数
 * datasource 数据源
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSString *>*)dataSource  countFoyY:(NSInteger)countY;

- (instancetype)initWithFrame:(CGRect)frame countFoyY:(NSInteger)countY;

//数据源 （赋值可重绘）
@property (nonatomic,strong) NSArray *dataSource;

// Y轴坐标数据， 根据dataSource 获取
@property (nonatomic, strong,readonly) NSArray *dataArrOfY;

// X轴坐标数据 默认为近期日期
@property (nonatomic, strong) NSArray *dataArrOfX;

//x轴，y轴标题
@property (nonatomic, copy) NSString *titleForX;
@property (nonatomic, copy) NSString *titleForY;


/**
 * 如果数据相同，仍然重新绘制曲线 默认 NO
 * 设为yes， 则只要重新设置数据源 都会有重绘动画，（tableView 上下滑动会出现动画）
 */
@property (nonatomic, assign) BOOL reSetUIWhenSameData;

/*
 * 样式 默认 ChatViewStyleSingleCurve
 */
@property (nonatomic, assign) ChatViewStyle style;

/*
 * 曲线颜色 默认 r:65 g:156 b:187
 */
@property (nonatomic, copy) UIColor *lineColor;

/*
 * 遮罩颜色
 * 遮罩颜色取 数组的第一个和最后一个
 * 不设置 将取 lineColor
 */
@property (nonatomic, copy) NSArray<UIColor *> *maskColors;

/*
 * 设置 点 的 图片和选中图片
 */
- (void)setPointImage:(UIImage *)image pointselectedImage:(UIImage *)selectedImg;


/*
 * 点被选中的时候，回调 当前 值和下标
 */
- (void)pointDidTapedCompletion:(void(^)(NSString *value,NSInteger index))block;

@end
