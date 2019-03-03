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
    
    self.navigationItem.title = @"新增|编辑";
    
    WS(weakSelf);
    SXHealthTimeHeaderView *headerView = [SXHealthTimeHeaderView headerView];
    headerView.clickBeginTimeControlBlock = ^{
        SXDatePickerView *pickerView = [SXDatePickerView pickerView];
        pickerView.confirmBtnBlock = ^(NSString * _Nonnull timeStr) {
            weakSelf.headerView.beginTimeStr = timeStr;
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
    headerView.clickConfirmBtnBlock = ^{
        DLog(@"点击确定...");
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end