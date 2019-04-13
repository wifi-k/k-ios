//
//  SXXiaoKiController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiController.h"
#import "SXUpdateVersionController.h"
#import "SXXiaoKiAddBindController.h"
#import "SXHomeXiaoKiCell.h"
#import "SXInputAlertView.h"
#import "SXTitleAlertView.h"
#import "SXMineNetTool.h"
#import "SXRootTool.h"

@interface SXXiaoKiController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation SXXiaoKiController

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
    
    self.navigationItem.title = @"我的小K";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"添加" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)rightButtonAction:(UIButton *)btn{
    DLog(@"btn:%@",btn.titleLabel.text);
    WS(weakSelf);
    SXXiaoKiAddBindController *addVC = [[SXXiaoKiAddBindController alloc] init];
    addVC.addBindSuccessBlock = ^{
        [weakSelf userNodeListData];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
    [self userNodeListData];
}

#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
    [self userNodeListMoreData];
}

#pragma mark -节点信息列表接口-
- (void)userNodeListData{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    self.pageIndex = 1;
    param.pageNo = @(self.pageIndex);
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMineNetTool userNodeListParams:param.mj_keyValues Success:^(SXHomeXiaoKiResult *result) {
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
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -节点信息列表接口更多-
- (void)userNodeListMoreData{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.pageNo = @(++self.pageIndex);
    param.pageSize = @10;
    [SXMineNetTool userNodeListParams:param.mj_keyValues Success:^(SXHomeXiaoKiResult *result) {
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
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -弹窗视图-
- (void)alertUpdateNameView:(SXHomeXiaoKiModel *)model{
    WS(weakSelf);
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"修改名称" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        model.name = text;
        [weakSelf userNodeInfoSetData:model];
    };
    [nameAlertView alert];
}

- (void)alertUnbindWithModel:(SXHomeXiaoKiModel *)model{
    WS(weakSelf);
    NSString *content = [NSString stringWithFormat:@"是否确定解绑小K云管家%@",model.name];
    SXTitleAlertView *unbindAV = [SXTitleAlertView alertWithTitle:@"解绑小K" content:content confirmStr:@"确定" cancelStr:@"取消"];
    unbindAV.confirmButtonBlock = ^{
        DLog(@"确定...");
        [weakSelf userNodeUnbindWithModel:model];
    };
    [unbindAV alert];
}

#pragma mark -解绑小K-
- (void)userNodeUnbindWithModel:(SXHomeXiaoKiModel *)model{
    //更新wan信息
    if ([NSString isEmpty:model.nodeId]) {
        [MBProgressHUD showWarningWithMessage:@"没有获取到节点，请检查系统网络设置!" toView:SXKeyWindow];
        return;
    }
    WS(weakSelf);
    [SXMineNetTool userNodeUnbindParams:model.nodeId Success:^{
        [MBProgressHUD showSuccessWithMessage:@"解绑成功!" toView:SXKeyWindow];
        //刷新表格显示
        [weakSelf.dataArray removeObject:model];
        [weakSelf.tableView reloadData];
        //如果列表为空，切换根控制器
        if (weakSelf.dataArray.count == 0) {
            [SXRootTool changeToHomeVC];
        }
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
        //刷新表格显示
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
    return 150.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXHomeXiaoKiCell *cell = [SXHomeXiaoKiCell cellWithTableView:tableView];
    SXHomeXiaoKiModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickUpdateNameBtnBlock = ^(SXHomeXiaoKiModel * _Nonnull model) {
        [weakSelf alertUpdateNameView:model];
    };
    cell.clickUnbindBtnBlock = ^(SXHomeXiaoKiModel * _Nonnull model) {
        [weakSelf alertUnbindWithModel:model];
    };
    cell.clickUpdateVersionBtnBlock = ^(SXHomeXiaoKiModel * _Nonnull model) {
        [weakSelf jumpToUpdateVersionVC:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
