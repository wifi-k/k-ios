//
//  SXForbiddenDeviceOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenDeviceOptionController.h"
#import "SXForbiddenDeviceOptionCell.h"
#import "SXXiaoKiOptionResult.h"
#import "SXWifiSettingNetTool.h"

@interface SXForbiddenDeviceOptionController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation SXForbiddenDeviceOptionController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //开始下拉刷新
    [self refresh];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"选择控制设备";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)button{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    NSMutableArray *selectedArr = [NSMutableArray array];
    NSInteger count = 0;
    for (SXMobileManagerModel *model in self.dataArray) {
        if (!model.isBlock.boolValue) {
            ++ count;
            if ([NSString isNotEmpty:model.mac]) {
                [selectedArr addObject:model.mac];
            }
        }
    }
    
    //回调出去
    if (self.selectForbiddenOptionBlock) {
        self.selectForbiddenOptionBlock(selectedArr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
    [self userNodeDeviceListData];
}

#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
    [self userNodeDeviceListMoreData];
}

#pragma mark -获取上网设备列表数据接口-
- (void)userNodeDeviceListData{
    WS(weakSelf);
    SXMobilePageParam *param = [SXMobilePageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    self.pageIndex = 1;
    param.pageNo = @(self.pageIndex);
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(SXMobileManagerResult * _Nonnull result) {
        [weakSelf endHeaderRefresh];
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        
        //数据初始化
        weakSelf.dataArray = [NSMutableArray arrayWithArray:result.page];
        //刷新UI
        [weakSelf.tableView reloadData];
        //判断是否到底
        if (weakSelf.dataArray.count >= result.total.integerValue) {
            [weakSelf showNoMoreDataFooterView];
        }
    } failure:^(NSError * _Nonnull error) {
        [weakSelf endHeaderRefresh];
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -获取上网设备列表数据接口-
- (void)userNodeDeviceListMoreData{
    WS(weakSelf);
    SXMobilePageParam *param = [SXMobilePageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    param.pageNo = @(++self.pageIndex);
    param.pageSize = @10;
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(SXMobileManagerResult * _Nonnull result) {
        [weakSelf endFooterRefresh];
        //数据初始化//刷新UI
        if (result.page.count) {
            [weakSelf.dataArray addObjectsFromArray:result.page];
            [weakSelf.tableView reloadData];
        } else {
            if (weakSelf.dataArray.count >= result.total.integerValue) {
                [weakSelf showNoMoreDataFooterView];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [weakSelf endFooterRefresh];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
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
    SXMobileManagerModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
