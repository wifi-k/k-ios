//
//  SXNetOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetOptionController.h"
#import "SXNetOptionCell.h"
#import "SXNetOptionFooterView.h"

@interface SXNetOptionController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXNetOptionController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        SXNetOptionModel *model0 = [[SXNetOptionModel alloc] init];
        model0.title = @"宽带拨号上网";
        model0.selected = @(YES);
        [_dataArray addObject:model0];
        
        SXNetOptionModel *model1 = [[SXNetOptionModel alloc] init];
        model1.title = @"静态IP上网";
        model1.selected = @(NO);
        [_dataArray addObject:model1];
        
        SXNetOptionModel *model2 = [[SXNetOptionModel alloc] init];
        model2.title = @"动态IP上网";
        model2.selected = @(NO);
        [_dataArray addObject:model2];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"选择上网方式";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
    //WS(weakSelf);
    SXNetOptionFooterView *footerView = [SXNetOptionFooterView footerView];
    footerView.dataArray = self.dataArray;
    footerView.clickNextBtnBlock = ^(SXNetOptionModel * _Nonnull model) {
        DLog(@"%@-%@",model.title,model.selected);
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXNetOptionCell *cell = [SXNetOptionCell cellWithTableView:tableView];
    SXNetOptionModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (SXNetOptionModel *model in self.dataArray) {
        model.selected = @(NO);
    }
    
    SXNetOptionModel *model = self.dataArray[indexPath.row];
    model.selected = @(YES);
    
    //刷新数组
    [self.tableView reloadData];
}

@end
