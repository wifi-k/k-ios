//
//  SXForbiddenDeviceOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenDeviceOptionController.h"
#import "SXForbiddenDeviceOptionCell.h"
#import "SXForbiddenAppOptionModel.h"

@interface SXForbiddenDeviceOptionController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXForbiddenDeviceOptionController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            SXForbiddenAppOptionModel *model = [[SXForbiddenAppOptionModel alloc] init];
            model.title = [NSString stringWithFormat:@"名称%d",i];
            model.row= @(i);
            model.selected = @(NO);
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"选择禁用的设备";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)button{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    NSInteger count = 0;
    for (SXForbiddenAppOptionModel *model in self.dataArray) {
        if (model.selected.boolValue) {
            ++ count;
        }
    }
    
    if (self.selectForbiddenOptionBlock) {
        NSString *fdfdf = [NSString stringWithFormat:@"%ld个",count];
        self.selectForbiddenOptionBlock(fdfdf);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXForbiddenDeviceOptionCell *cell = [SXForbiddenDeviceOptionCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
