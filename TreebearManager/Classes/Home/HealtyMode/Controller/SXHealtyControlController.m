//
//  SXHealtyControlController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHealtyControlController.h"
#import "SXHealtyTimeController.h"
#import "SXHealtyControlHeaderView.h"
#import "SXHealtyControlFooterView.h"
#import "SXHealtyControlCell.h"
#import "SXHealtyModeNetTool.h"
#import "SXXiaoKInfoModel.h"
#import "NSArray+Extension.h"

@interface SXHealtyControlController ()
///头部视图
@property (nonatomic, weak) SXHealtyControlHeaderView *headerView;
///底部视图
@property (nonatomic, weak) SXHealtyControlFooterView *footerView;

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXHealtyControlController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
//        NSArray *array = @[@{@"freq":@0,@"rssi":@5,@"timer":@[@{@"startTime":@"00:00",@"endTime":@"00:01"},@{@"startTime":@"00:01",@"endTime":@"00:02"}]}];
//        _dataArray = [NSMutableArray arrayWithArray:[SXHealtyControlModel mj_objectArrayWithKeyValuesArray:array]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
    
    //初始化数据
    [self setUpData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"健康模式";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 100;
    self.tableView.tableFooterView = footerBgView;
    
    WS(weakSelf);
    SXHealtyControlFooterView *footerView = [SXHealtyControlFooterView footerView];
    footerView.clickAddTimeBlock = ^{
        [weakSelf jumpToTimeVC:nil];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    
    SXHealtyControlHeaderView *headerView = [SXHealtyControlHeaderView headerView];
    headerView.clickSwitchBtnBlock = ^(BOOL isOn) {
        DLog(@"isOn:%d",isOn);
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 177);
}

- (void)rightButtonAction:(UIButton *)button{
    [self userNodeRssiTimerSetData];
}

#pragma mark -获取网络数据-
- (void)setUpData{
    WS(weakSelf);
    SXHealtyControlParam *param = [SXHealtyControlParam param];
    param.nodeId = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId;
    [SXHealtyModeNetTool userNodeWifiTimerGetDataWithParams:param.mj_keyValues Success:^(SXHealtyControlResult *result) {
        DLog(@"result:%@",result);
        //赋值视图
        weakSelf.headerView.op = result.op;
        //赋值
        weakSelf.dataArray = [NSMutableArray arrayWithArray:result.wifi];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -网络设置-
- (void)userNodeRssiTimerSetData{
    [MBProgressHUD showWhiteLoadingWithMessage:@"正在设置..." toView:SXKeyWindow];
    SXHealtyControlParam *param = [SXHealtyControlParam param];
    param.nodeId = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId;
    param.op = [self.headerView isSwitchOn];
    if (self.dataArray.count) {
        param.wifi = [self.dataArray yy_modelToJSONString];
    }
    [SXHealtyModeNetTool userNodeWifiTimerSetDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -页面跳转-
- (void)jumpToTimeVC:(SXHealtyControlTimeModel *)model{
    WS(weakSelf);
    SXHealtyTimeController *timeVC = [[SXHealtyTimeController alloc] init];
    BOOL isAdd = (model == nil? YES:NO);
    timeVC.model = model;
    timeVC.selectTimeOptionBlock = ^(SXHealtyControlTimeModel * _Nonnull model) {
        if (isAdd) {
            SXHealtyControlModel *result = [[SXHealtyControlModel alloc] init];
            result.timer = @[model];
            [weakSelf.dataArray addObject:result];
        }
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:timeVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SXHealtyControlModel *model = self.dataArray[section];
    return model.timer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    SXHealtyControlCell *cell = [SXHealtyControlCell cellWithTableView:tableView];
    SXHealtyControlModel *model = self.dataArray[indexPath.section];
    SXHealtyControlTimeModel *timeModel = model.timer[indexPath.row];
    cell.model = timeModel;
    cell.clickEditBtnBlock = ^(SXHealtyControlTimeModel * _Nonnull model) {
        [weakSelf jumpToTimeVC:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark -添加滑动删除-
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SXHealtyControlModel *model = self.dataArray[indexPath.section];
//        SXHealtyControlTimeModel *timeModel = model.timer[indexPath.row];
        
//        [self.dataArray removeObjectAtIndex:indexPath.row];
    }
}



@end
