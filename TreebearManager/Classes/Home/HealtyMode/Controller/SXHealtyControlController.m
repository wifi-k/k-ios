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
#import "SXHealtyControlCell.h"

@interface SXHealtyControlController ()
///头部视图
@property (nonatomic, weak) SXHealtyControlHeaderView *headerView;

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
    
    WS(weakSelf);
    SXHealtyControlHeaderView *headerView = [SXHealtyControlHeaderView headerView];
    headerView.clickEditTimeBlock = ^{
        [weakSelf jumpToTimeVC];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 177);
}

#pragma mark -页面跳转-
- (void)jumpToTimeVC{
    SXHealtyTimeController *timeVC = [[SXHealtyTimeController alloc] init];
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
    cell.clickEditBtnBlock = ^{
        [weakSelf jumpToTimeVC];
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
