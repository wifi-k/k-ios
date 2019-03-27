//
//  SXHealtyTimeController.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyTimeController.h"
#import "SXHealthTimeHeaderView.h"
#import "SXDatePickerView.h"

@interface SXHealtyTimeController ()
///头部视图
@property (nonatomic, weak) SXHealthTimeHeaderView *headerView;
@end

@implementation SXHealtyTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    BOOL isAdd = (self.model == nil? YES:NO);
    if (isAdd) {
        self.navigationItem.title = @"新增";
    } else{
        self.navigationItem.title = @"编辑";
    }
    
    WS(weakSelf);
    SXHealthTimeHeaderView *headerView = [SXHealthTimeHeaderView headerView];
    if (isAdd) {
        SXHealtyControlTimeModel *addModel = [[SXHealtyControlTimeModel alloc] init];
        addModel.startTime = @"00:00";
        addModel.endTime = @"00:00";
        headerView.model = addModel;
        self.model = addModel;
    } else {
        headerView.model = self.model;
    }
    headerView.clickBeginTimeControlBlock = ^{
        SXDatePickerView *pickerView = [SXDatePickerView pickerView];
        pickerView.confirmBtnBlock = ^(NSString * _Nonnull timeStr) {
            weakSelf.headerView.startTimeStr = timeStr;
        };
        [pickerView showPickerView];
    };
    headerView.clickEndTimeControlBlock = ^{
        SXDatePickerView *pickerView = [SXDatePickerView pickerView];
        pickerView.confirmBtnBlock = ^(NSString * _Nonnull timeStr) {
            weakSelf.headerView.endTimeStr = timeStr;
        };
        [pickerView showPickerView];
    };
    headerView.clickConfirmBtnBlock = ^(SXHealtyControlTimeModel * _Nonnull model) {
        DLog(@"%@-%@",model.startTime,model.endTime);
        if (self.selectTimeOptionBlock) {
            self.selectTimeOptionBlock(model);
        }
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
