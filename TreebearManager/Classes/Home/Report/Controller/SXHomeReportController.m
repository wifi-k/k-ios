//
//  SXHomeReportController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportController.h"
#import "SXHomeReportDetailController.h"
#import "SXHomeReportTableCell.h"
#import "SXXiaoKiOptionResult.h"
#import "SXHomeReportNetTool.h"

@interface SXHomeReportController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation SXHomeReportController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -埋点统计示例-
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
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
    
    self.navigationItem.title = @"周报";
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
    [self userNodeDeviceWeekListData];
}

#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
    [self userNodeDeviceWeekListMoreData];
}

#pragma mark -获取设备一周上网时长-
- (void)userNodeDeviceWeekListData{
    WS(weakSelf);
    SXHomeReportPageParam *param = [SXHomeReportPageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    self.pageIndex = 1;
    param.pageNo = @(self.pageIndex);
    param.pageSize = @10;
    [MBProgressHUD showGaryLoadingWithMessage:@"" toView:SXKeyWindow];
    [SXHomeReportNetTool userNodeDeviceWeekListParams:param.mj_keyValues Success:^(SXHomeReportResult *result) {
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
    } failure:^(NSError *error) {
        [weakSelf endHeaderRefresh];
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

- (void)userNodeDeviceWeekListMoreData{
    WS(weakSelf);
    SXHomeReportPageParam *param = [SXHomeReportPageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    param.pageNo = @(++self.pageIndex);
    param.pageSize = @10;
    [SXHomeReportNetTool userNodeDeviceWeekListParams:param.mj_keyValues Success:^(SXHomeReportResult *result) {
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
    } failure:^(NSError *error) {
        [weakSelf endFooterRefresh];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXHomeReportTableCell *cell = [SXHomeReportTableCell cellWithTableView:tableView];
    SXHomeReportModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXHomeReportDetailController *detailVC = [[SXHomeReportDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
