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
#import "SXDatePickerView.h"
#import "SXTitleAlertView.h"

@interface SXTimeControlController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXTimeControlController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        SXForbiddenAppModel *model0 = [[SXForbiddenAppModel alloc] init];
        model0.title = @"上网时间控制1";
        model0.row= @(0);
        [_dataArray addObject:model0];
        
        SXForbiddenAppModel *model1 = [[SXForbiddenAppModel alloc] init];
        model1.title = @"上网时间控制2";
        model1.row= @(1);
        [_dataArray addObject:model1];
        
        SXForbiddenAppModel *model2 = [[SXForbiddenAppModel alloc] init];
        model2.title = @"上网时间控制3";
        model2.row= @(2);
        [_dataArray addObject:model2];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
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
        [weakSelf jumpToUpdateVC];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVC{
    SXTimeUpdateController *updateVC = [[SXTimeUpdateController alloc] init];
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
    SXForbiddenAppModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickEditBtnBlock = ^{
        [weakSelf jumpToUpdateVC];
    };
    cell.clickDeleteBtnBlock = ^{
        [weakSelf alertDeleteAlertView];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXDatePickerView *pickerView = [SXDatePickerView pickerView];
    [pickerView showPickerView];
}

@end
