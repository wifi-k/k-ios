//
//  SXTimeControlController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlController.h"
#import "SXTimeUpdateController.h"
#import "SXForbiddenAppFooterView.h"
#import "SXTimeControlCell.h"
#import "SXWifiSettingAlertView.h"
#import "SXTitleAlertView.h"
#import "SXXiaoKiOptionResult.h"
#import "SXParentControlNetTool.h"

@interface SXTimeControlController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXTimeControlController

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
    
    //2.上网时间列表
    [self userNodeDeviceAllowListData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"上网时间控制";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
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

#pragma mark -页面跳转-
- (void)jumpToUpdateVC:(SXTimeControlModel *)model{
    SXTimeUpdateController *updateVC = [[SXTimeUpdateController alloc] init];
    updateVC.model = model;
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView{
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此方案吗?" confirmStr:@"确定" cancelStr:@"取消"];
    deleteAlertView.confirmButtonBlock = ^{
        DLog(@"确定。。。");
    };
    [deleteAlertView alert];
}

#pragma mark -获取设备上网配置列表接口-
- (void)userNodeDeviceAllowListData{
    WS(weakSelf);
    SXForbiddenAppParam *param = [SXForbiddenAppParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXParentControlNetTool userNodeDeviceAllowListParams:param.mj_keyValues Success:^(SXTimeControlResult *result) {
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
    SXTimeControlCell *cell = [SXTimeControlCell cellWithTableView:tableView];
    SXTimeControlModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickEditBtnBlock = ^{
        [weakSelf jumpToUpdateVC:nil];
    };
    cell.clickDeleteBtnBlock = ^{
        [weakSelf alertDeleteAlertView];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
