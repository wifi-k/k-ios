//
//  SXForbiddenAppController.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppController.h"
#import "SXForbiddenUpdateController.h"
#import "SXForbiddenAppHeaderView.h"
#import "SXForbiddenAppFooterView.h"
#import "SXForbiddenAppCell.h"
#import "SXTitleAlertView.h"
#import "SXForbiddenAppModel.h"
#import "SXParentControlNetTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXForbiddenAppController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXForbiddenAppController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
    
    //2.数据接口
    [self userNodeDeviceAllowListData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"禁用";
    
    //3.添加头部视图
    UIView *headerBgView = [[UIView alloc] init];
    headerBgView.backgroundColor = SXColorWhite;
    headerBgView.height = 80;
    self.tableView.tableHeaderView = headerBgView;
    
    SXForbiddenAppHeaderView *headerV = [SXForbiddenAppHeaderView headerView];
    [self.tableView.tableHeaderView addSubview:headerV];
    headerV.frame = self.tableView.tableHeaderView.bounds;
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    WS(weakSelf);
    SXForbiddenAppFooterView *footerView = [SXForbiddenAppFooterView
                                            footerView];
    footerView.clickAddForbiddenBlock = ^{
        [weakSelf jumpToUpdateVC:nil];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView:(SXForbiddenAppModel *)model{
    WS(weakSelf);
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此方案吗?" confirmStr:@"确定" cancelStr:@"取消"];
    deleteAlertView.confirmButtonBlock = ^{
        [weakSelf userNodeDeviceAllowDelData:model];
    };
    [deleteAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVC:(SXForbiddenAppModel *)model{
    WS(weakSelf);
    SXForbiddenUpdateController *updateVC = [[SXForbiddenUpdateController alloc] init];
    BOOL isAdd = (model == nil? YES:NO);
    updateVC.model = model;
    updateVC.selectForbiddenOptionBlock = ^(SXForbiddenAppModel * _Nonnull model) {
        if (isAdd) {
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark -获取设备上网配置列表接口-
- (void)userNodeDeviceAllowListData{
    WS(weakSelf);
    SXForbiddenAppParam *param = [SXForbiddenAppParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXParentControlNetTool forbiddenUserNodeDeviceAllowListParams:param.mj_keyValues Success:^(SXForbiddenAppResult *result) {
        DLog(@"result:%@",result);
        weakSelf.dataArray = [NSMutableArray arrayWithArray:result.page];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -删除设备上网配置接口-
- (void)userNodeDeviceAllowDelData:(SXForbiddenAppModel *)model{
    WS(weakSelf);
    SXForbiddenAppParam *param = [SXForbiddenAppParam param];
    param.modelId = model.modelId;
    param.nodeId = model.nodeId;
    [SXParentControlNetTool userNodeDeviceAllowDelParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"删除成功!" toView:SXKeyWindow];
        
        //刷新显示
        [weakSelf.dataArray removeObject:model];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
    WS(weakSelf);
    SXForbiddenAppCell *cell = [SXForbiddenAppCell cellWithTableView:tableView];
    SXForbiddenAppModel *model = self.dataArray[indexPath.row];
    model.row = @(indexPath.row);
    cell.model = model;
    cell.clickEditBtnBlock = ^(SXForbiddenAppModel * _Nonnull model) {
        [weakSelf jumpToUpdateVC:model];
    };
    cell.clickDeleteBtnBlock = ^(SXForbiddenAppModel * _Nonnull model) {
        [weakSelf alertDeleteAlertView:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
