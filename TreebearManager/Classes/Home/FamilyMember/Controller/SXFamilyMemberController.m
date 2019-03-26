//
//  SXFamilyMemberController.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberController.h"
#import "SXFamilyMemberFooterView.h"
#import "SXFamilyMemberCell.h"
#import "SXWifiSettingAlertView.h"
#import "SXTitleAlertView.h"
#import "SXFamilyMemberNetTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXFamilyMemberController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXFamilyMemberController

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
    
    //家庭成员列表数据
    [self userNodeFamilyListData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"家庭成员";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
    WS(weakSelf);
    SXFamilyMemberFooterView *footerView = [SXFamilyMemberFooterView
                                            footerView];
    footerView.clickAddMemberBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入家庭码" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf userNodeFamilyJoin:text];
    };
    [nameAlertView alert];
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView:(SXFamilyMemberModel *)model{
    WS(weakSelf);
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此成员吗?" confirmStr:@"确定" cancelStr:@"取消"];
    deleteAlertView.confirmButtonBlock = ^{
        [weakSelf userNodeFamilyQuitData:model];
    };
    [deleteAlertView alert];
}

#pragma mark -网络请求接口-
- (void)userNodeFamilyListData{
    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXFamilyMemberNetTool userNodeFamilyListDataWithParams:param.mj_keyValues Success:^(NSArray *array) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"array:%@",array);
        //刷新表格显示
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)userNodeFamilyJoin:(NSString *)text{
//    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    param.inviteCode = text;
    [SXFamilyMemberNetTool userNodeFamilyJoinDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"添加成功!" toView:SXKeyWindow];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)userNodeFamilyQuitData:(SXFamilyMemberModel *)model{
//    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    param.nodeId = model.nodeId;
    param.userId = model.userId;
    [SXFamilyMemberNetTool userNodeFamilyQuitDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
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
    SXFamilyMemberCell *cell = [SXFamilyMemberCell cellWithTableView:tableView];
    SXFamilyMemberModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickDeleteBtnBlock = ^(SXFamilyMemberModel *model) {
        [weakSelf alertDeleteAlertView:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
