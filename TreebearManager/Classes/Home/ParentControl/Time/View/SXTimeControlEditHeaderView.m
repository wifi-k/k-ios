//
//  SXTimeControlEditHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlEditHeaderView.h"

@interface SXTimeControlEditHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *beginTimeL;
@property (weak, nonatomic) IBOutlet UIView *firstBgView;

@property (weak, nonatomic) IBOutlet UILabel *endTimeL;
@property (weak, nonatomic) IBOutlet UIView *secondBgView;

@property (weak, nonatomic) IBOutlet UIView *weekBgView;

@property (weak, nonatomic) IBOutlet UIButton *recycleBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXTimeControlEditHeaderView

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSArray *array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        _dataArray = [NSMutableArray arrayWithArray:array];
    }
    return _dataArray;
}

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

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.backgroundColor = SXColorBgViewGray;
    
    self.firstBgView.backgroundColor = SXColorWhite;
    self.secondBgView.backgroundColor = SXColorWhite;
    
    self.firstBgView.backgroundColor = [UIColor whiteColor];
    self.firstBgView.layer.cornerRadius = 5;
    self.firstBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.firstBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.firstBgView.layer.shadowOpacity = 0.5;
    self.firstBgView.layer.shadowRadius = 3;
    
    self.secondBgView.backgroundColor = [UIColor whiteColor];
    self.secondBgView.layer.cornerRadius = 5;
    self.secondBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.secondBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.secondBgView.layer.shadowOpacity = 0.5;
    self.secondBgView.layer.shadowRadius = 5;
    
    [self.confirmBtn roundViewWithRadius:6.0f];
    
    //添加事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBeginTimeControl:)];
    [self.firstBgView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEndTimeControl:)];
    [self.secondBgView addGestureRecognizer:tap2];
    
    NSInteger count = self.dataArray.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 40;
    CGFloat btnH = 40;
    CGFloat marginW = (SCREEN_WIDTH - 15*2 - count* btnW)/(count-1);
    for (int i=0; i<count; i++) {
        btnX = i * (btnW + marginW);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        NSString *title = self.dataArray[i];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:SXColor999999 forState:UIControlStateNormal];
        [btn setTitleColor:SXColorWhite forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_timeoption_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_timeoption_selected"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickWeekBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn roundViewWithRadius:20.0f];
        [self.weekBgView addSubview:btn];
    }
    self.weekBgView.backgroundColor = SXColorClear;
    
    self.recycleBtn.titleLabel.font = SXFontBold18;
    [self.recycleBtn setTitleColor:SXColor333333 forState:UIControlStateNormal];
    
    //默认值
    self.endTimeStr = @"00:00";
    self.beginTimeStr = @"00:00";
}

#pragma mark -点击事件-
- (void)clickWeekBtn:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    
    for (UIButton *subBtn in self.weekBgView.subviews) {
        if (subBtn.isSelected) {//打印已选中
            DLog(@"text:%@",subBtn.titleLabel.text);
        }
    }
}

- (IBAction)clickRecycleBtn:(UIButton *)sender {
    
}


#pragma mark -setter-
- (void)setBeginTimeStr:(NSString *)beginTimeStr{
    _beginTimeStr = beginTimeStr;
    
    self.beginTimeL.text = beginTimeStr;
}

- (void)setEndTimeStr:(NSString *)endTimeStr{
    _endTimeStr = endTimeStr;
    
    self.endTimeL.text = endTimeStr;
}

#pragma mark -点击事件-
- (IBAction)clickConfirmBtn:(UIButton *)sender {
    if (self.clickConfirmBtnBlock) {
        self.clickConfirmBtnBlock(self.beginTimeStr,self.endTimeStr);
    }
}

- (void)clickBeginTimeControl:(UITapGestureRecognizer *)sender {
    if (self.clickBeginTimeControlBlock) {
        self.clickBeginTimeControlBlock();
    }
}

- (void)clickEndTimeControl:(UITapGestureRecognizer *)sender {
    if (self.clickEndTimeControlBlock) {
        self.clickEndTimeControlBlock();
    }
}

@end
