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
    
    //获取设备一周上网时长
    [self userNodeDeviceWeekListData];
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

#pragma mark -获取设备一周上网时长-
- (void)userNodeDeviceWeekListData{
    SXHomeReportPageParam *param = [SXHomeReportPageParam param];
    param.pageNo = @1;
    param.pageSize = @10;
    [SXHomeReportNetTool userNodeDeviceWeekListParams:param.mj_keyValues Success:^(SXHomeReportResult *result) {
        DLog(@"result:%@",result.mj_keyValues);
    } failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXHomeReportTableCell *cell = [SXHomeReportTableCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXHomeReportDetailController *detailVC = [[SXHomeReportDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
