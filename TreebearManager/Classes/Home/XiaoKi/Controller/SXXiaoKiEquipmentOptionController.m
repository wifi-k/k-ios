//
//  SXXiaoKiEquipmentOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiEquipmentOptionController.h"
#import "SXUpdateVersionController.h"
#import "SXXiaoKiEquipmentOptionCell.h"
#import "SXMineNetTool.h"
#import "SXFamilyMemberNetTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXXiaoKiEquipmentOptionController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation SXXiaoKiEquipmentOptionController

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
    
    //开始下拉刷新
    [self refresh];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"切换小K";
}

#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
    [self userNodeListallData];
}

#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
    [self userNodeListallMoreData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -setData(列表)-
- (void)userNodeListallData{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    self.pageIndex = 1;
    param.pageNo = @(self.pageIndex);
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
//    SXMineNetTool userNodeListallParams
//    SXMineNetTool userNodeListParams
    [SXMineNetTool userNodeListallParams:param.mj_keyValues Success:^(SXHomeXiaoKiResult *result) {
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
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -更多家庭节点列表-
- (void)userNodeListallMoreData{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.pageNo = @(++self.pageIndex);
    param.pageSize = @10;
    [SXMineNetTool userNodeListallParams:param.mj_keyValues Success:^(SXHomeXiaoKiResult *result) {
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
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -用户选定节点-
- (void)userNodeSelectData{
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXFamilyMemberNetTool userNodeSelectDataWithParams:param.mj_keyValues Success:^{
        NSString *equipName = [NSString stringWithFormat:@"已为您切换设备:%@",model.name];
        [MBProgressHUD showSuccessWithMessage:equipName toView:SXKeyWindow];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -节点名称修改-
- (void)userNodeInfoSetData:(SXHomeXiaoKiModel *)model{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.name = model.name;
    param.nodeId = model.nodeId;
    [SXMineNetTool userNodeInfoSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        //刷新表格
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVersionVC:(SXHomeXiaoKiModel *)model{
    SXUpdateVersionController *updateVC = [[SXUpdateVersionController alloc] init];
    updateVC.model = model;
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXXiaoKiEquipmentOptionCell *cell = [SXXiaoKiEquipmentOptionCell cellWithTableView:tableView];
    SXHomeXiaoKiModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXHomeXiaoKiModel *model = self.dataArray[indexPath.row];
    SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel = model;
    if (self.selectOptionModelBlock) {
        self.selectOptionModelBlock();
    }
    
    //告诉服务端选中的模型
    [self userNodeSelectData];
    
    //跳转
    [self.navigationController popViewControllerAnimated:YES];
}

@end
