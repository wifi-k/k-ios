//
//  SXHomeReportReusableView.m
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportReusableView.h"
#import "WYLineChartPoint.h"
#import "WYChartCategory.h"
#import "WYLineChartCalculator.h"

@interface SXHomeReportReusableView ()<WYLineChartViewDelegate,WYLineChartViewDatasource>
@property (weak, nonatomic) IBOutlet UILabel *timeL;


@property (weak, nonatomic) IBOutlet UIView *chartBgView;

@property (weak, nonatomic) IBOutlet UILabel *appL;

@property (nonatomic , weak) WYLineChartView *lineChart;//折线图
///X轴
@property (nonatomic, strong) NSArray *points;
@property (nonatomic, strong) NSMutableArray *arrayValue;
@property (nonatomic, strong) NSMutableArray *arrayTitle;
@end

@implementation SXHomeReportReusableView

#pragma mark -getter方法-
- (NSMutableArray *)arrayValue{
    if (_arrayValue == nil) {
        NSArray *values = @[@1,@2,@3,@1,@2,@3,@2];
        _arrayValue = [NSMutableArray arrayWithArray:values];
    }
    return _arrayValue;
}

- (NSMutableArray *)arrayTitle{
    if (_arrayTitle == nil) {
        NSArray *titles = @[@"10.1",@"10.2",@"10.3",@"10.4",@"10.5",@"10.6",@"10.7"];
        _arrayTitle = [NSMutableArray arrayWithArray:titles];
    }
    return _arrayTitle;
}

+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.timeL.font = SXFontBold18;
    self.appL.font = SXFontBold18;
    
    self.timeL.textColor = SXColor333333;
    self.appL.textColor = SXColor333333;
    
    self.chartBgView.backgroundColor = [UIColor whiteColor];
    self.chartBgView.layer.cornerRadius = 5;
    self.chartBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.chartBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.chartBgView.layer.shadowOpacity = 0.5;
    self.chartBgView.layer.shadowRadius = 5;
    
    //2.添加图表
    WYLineChartView *lineChart = [[WYLineChartView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 60, 160)];
    lineChart.delegate = self;
    lineChart.datasource = self;
    lineChart.touchPointColor = SXColorBlue2;
    lineChart.yAxisHeaderPrefix = nil;
    lineChart.yAxisHeaderSuffix = nil;
    lineChart.labelsFont = [UIFont systemFontOfSize:13];
    lineChart.verticalReferenceLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    lineChart.horizontalRefernenceLineColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    lineChart.axisColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    lineChart.labelsColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    lineChart.animationDuration = 3.0f;
    lineChart.animationStyle = kWYLineChartAnimationWidth;
    lineChart.backgroundColor = UIColor.whiteColor;
    lineChart.scrollable = YES;
    lineChart.pinchable = YES;
    [self.chartBgView addSubview:lineChart];
    self.lineChart = lineChart;
    
    //1.
    [self updateGraph];
}

#pragma mark -重新绘制图表-
- (void)updateGraph{
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *points = [WYLineChartPoint pointsFromValueArray:self.arrayValue];
    [mutableArray addObject:points];
    self.lineChart.points = [NSArray arrayWithArray:mutableArray];
    self.points = mutableArray;
    [self.lineChart updateGraph];
}

#pragma mark -WYLineChartViewDelegate代理-
- (NSInteger)numberOfLabelOnXAxisInLineChartView:(WYLineChartView *)chartView {
    return [self.points.firstObject count];
}

- (NSInteger)numberOfLabelOnYAxisInLineChartView:(WYLineChartView *)chartView {
    return 1;
}

- (CGFloat)gapBetweenPointsHorizontalInLineChartView:(WYLineChartView *)chartView {
    return 60.f;
}

- (NSInteger)numberOfReferenceLineVerticalInLineChartView:(WYLineChartView *)chartView {
    return [self.points.firstObject count];
}

- (NSInteger)numberOfReferenceLineHorizontalInLineChartView:(WYLineChartView *)chartView {
    return 1;
}

#pragma mark - WYLineChartViewDatasource代理 -
- (NSString *)lineChartView:(WYLineChartView *)chartView contextTextForPointAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *pointsArray = self.lineChart.points[indexPath.section];
    WYLineChartPoint *point = pointsArray[indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%lu", (NSInteger)point.value];
    return text;
}

- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForXAxisLabelAtIndex:(NSInteger)index {
    return self.arrayTitle[index];
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToXAxisLabelAtIndex:(NSInteger)index {
    return self.points.firstObject[index];
}

- (WYLineChartPoint *)lineChartView:(WYLineChartView *)chartView pointReferToVerticalReferenceLineAtIndex:(NSInteger)index {
    return self.points.firstObject[index];
}

- (NSString *)lineChartView:(WYLineChartView *)chartView contentTextForYAxisLabelAtIndex:(NSInteger)index {
    
    CGFloat value = [self.lineChart.calculator minValuePointsOfLinesPointSet:self.lineChart.points].value;
    return [NSString stringWithFormat:@"%lu", (NSInteger)value];
}

- (CGFloat)lineChartView:(WYLineChartView *)chartView valueReferToYAxisLabelAtIndex:(NSInteger)index {
    
    CGFloat value = [self.lineChart.calculator minValuePointsOfLinesPointSet:self.lineChart.points].value;
    return value;
}

- (CGFloat)lineChartView:(WYLineChartView *)chartView valueReferToHorizontalReferenceLineAtIndex:(NSInteger)index {
    
    CGFloat value  = [self.lineChart.calculator minValuePointsOfLinesPointSet:self.lineChart.points].value;
    return value;
}

- (NSDictionary *)lineChartView:(WYLineChartView *)chartView attributesForLineAtIndex:(NSUInteger)index {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[kWYLineChartLineAttributeLineStyle] = @1;
    dict[kWYLineChartLineAttributeDrawGradient] = @1;
    dict[kWYLineChartLineAttributeJunctionStyle] = @1;
    dict[kWYLineChartLineAttributeLineColor] = SXColorRGBA(165.f, 203.f, 211.f, 0.9);;
    dict[kWYLineChartLineAttributeJunctionColor] = SXColorRGBA(165.f, 203.f, 211.f, 0.9);
    return dict;
}

@end
