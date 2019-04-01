//
//  SXMobileManagerController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileManagerController.h"
#import "SXMobileDetailController.h"
#import "SXMobileManagerHeaderView.h"
#import "SXMobileManagerCell.h"
#import "SXInputAlertView.h"
#import "SXXiaoKiOptionResult.h"
#import "SXMobilePageParam.h"
#import "SXWifiSettingNetTool.h"

@interface SXMobileManagerController ()
//头部视图
@property (nonatomic, weak) SXMobileManagerHeaderView *headerView;
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXMobileManagerController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self userNodeDeviceListData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"连网设备";
    
    //2.头部视图
    SXMobileManagerHeaderView *headerView = [SXMobileManagerHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
}

#pragma mark -弹窗视图-
- (void)alertRemarkNameView{
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -获取上网设备列表数据接口-
- (void)userNodeDeviceListData{
    WS(weakSelf);
    SXMobilePageParam *param = [SXMobilePageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    param.pageNo = @1;
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(SXMobileManagerResult * _Nonnull result) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        
        //数据初始化
        weakSelf.dataArray = [NSMutableArray arrayWithArray:result.page];
        //刷新UI
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXMobileManagerCell *cell = [SXMobileManagerCell cellWithTableView:tableView];
    SXMobileManagerModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickRemarkBtnBlock = ^{
        [weakSelf alertRemarkNameView];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
