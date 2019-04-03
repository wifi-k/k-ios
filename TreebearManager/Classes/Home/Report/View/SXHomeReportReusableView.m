//
//  SXHomeReportReusableView.m
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportReusableView.h"
#import "ORChartView.h"

@interface SXHomeReportReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;


@property (weak, nonatomic) IBOutlet UIView *chartBgView;

@property (weak, nonatomic) IBOutlet UILabel *appL;

@property (nonatomic , weak) ORChartView *lineChart;//折线图
///X轴
@property (nonatomic, strong) NSArray *points;
@property (nonatomic, strong) NSMutableArray *arrayValue;
@property (nonatomic, strong) NSMutableArray *arrayTitle;
@end

@implementation SXHomeReportReusableView

#pragma mark -getter方法-
//- (NSMutableArray *)arrayValue{
//    if (_arrayValue == nil) {
//        NSArray *values = @[@1,@2,@3,@1,@2,@3,@2];
//        _arrayValue = [NSMutableArray arrayWithArray:values];
//    }
//    return _arrayValue;
//}
//
//- (NSMutableArray *)arrayTitle{
//    if (_arrayTitle == nil) {
//        NSArray *titles = @[@"10.1",@"10.2",@"10.3",@"10.4",@"10.5",@"10.6",@"10.7"];
//        _arrayTitle = [NSMutableArray arrayWithArray:titles];
//    }
//    return _arrayTitle;
//}

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
    ORChartView *lineChart = [[ORChartView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 60, 160) dataSource:@[@"123",@"88", @"45",@"33"] countFoyY:7];
    lineChart.titleForX = @"日期/日";
    lineChart.titleForY = @"收益/元";
    [lineChart pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, (long)index);
    }];
    [self.chartBgView addSubview:lineChart];
    self.lineChart = lineChart;
    
    //3.刷新表格
    [self updateGraph];
}

#pragma mark -重新绘制图表-
- (void)updateGraph{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
     随机数据源
     随机样式
     随机颜色
     */
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 3000;
        [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
    }
    
    self.lineChart.dataSource = [array copy];
    self.lineChart.style = arc4random() % 4;
    self.lineChart.lineColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
}

@end
