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
        NSArray *array = @[@{@"startTime":@"00:00",@"endTime":@"00:01"},
                           @{@"startTime":@"00:01",@"endTime":@"00:02"}];
        _dataArray = [NSMutableArray arrayWithArray:[SXHealtyControlModel mj_objectArrayWithKeyValuesArray:array]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpUI];
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
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
}

#pragma mark -页面跳转-
- (void)jumpToTimeVC:(SXHealtyControlModel *)model{
    WS(weakSelf);
    SXHealtyTimeController *timeVC = [[SXHealtyTimeController alloc] init];
    BOOL isAdd = (model == nil? YES:NO);
    timeVC.model = model;
    timeVC.selectTimeOptionBlock = ^(SXHealtyControlModel * _Nonnull model) {
        if (isAdd) {
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:timeVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    SXHealtyControlCell *cell = [SXHealtyControlCell cellWithTableView:tableView];
    SXHealtyControlModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.clickEditBtnBlock = ^(SXHealtyControlModel * _Nonnull model) {
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

@end
