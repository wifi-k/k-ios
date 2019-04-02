//
//  SXMineChildController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineCHildController.h"
#import "SXMineAddChildController.h"
#import "SXForbiddenAppFooterView.h"
#import "SXMineChildCell.h"

@interface SXMineChildController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXMineChildController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        SXMineChildModel *model0 = [[SXMineChildModel alloc] init];
        model0.title = @"小叮当";
        model0.row= @(0);
        [_dataArray addObject:model0];
        
        SXMineChildModel *model1 = [[SXMineChildModel alloc] init];
        model1.title = @"大叮当";
        model1.row= @(1);
        [_dataArray addObject:model1];
        
        SXMineChildModel *model2 = [[SXMineChildModel alloc] init];
        model2.title = @"大毛";
        model2.row= @(2);
        [_dataArray addObject:model2];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"我的孩子";
    
    self.view.backgroundColor = SXColorWhite;
    
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
        [weakSelf jumpToAddVC];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -页面跳转-
- (void)jumpToAddVC{
    SXMineAddChildController *addVC = [[SXMineAddChildController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXMineChildCell *cell = [SXMineChildCell cellWithTableView:tableView];
    SXMineChildModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
