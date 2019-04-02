//
//  SXTimeControlEditController.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlEditController.h"
#import "SXDatePickerView.h"
#import "SXTimeControlEditHeaderView.h"

@interface SXTimeControlEditController ()
///头部视图
@property (nonatomic, weak) SXTimeControlEditHeaderView *headerView;
@end

@implementation SXTimeControlEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"编辑时间";

    WS(weakSelf);
    SXTimeControlEditHeaderView *headerView = [SXTimeControlEditHeaderView headerView];
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
    headerView.clickConfirmBtnBlock = ^(SXTimeControlParam * _Nonnull param) {
        DLog(@"点击确定...");
        if (self.selectTimeBlock) {
            self.selectTimeBlock(param);
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
