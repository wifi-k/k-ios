//
//  SXMessageController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMessageController.h"
#import "SXMessageHeaderView.h"
#import "SXHomeMessageCell.h"
#import "SXMessageNetTool.h"

@interface SXMessageController ()
//头部视图
@property (nonatomic, weak) SXMessageHeaderView *headerView;

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
///页码
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation SXMessageController

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
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"消息中心";
    
    //2.头部视图
    SXMessageHeaderView *headerView = [SXMessageHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
}

#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
    [self userMessageListData];
}

#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
    [self userMessageListMoreData];
}

#pragma mark -查询用户消息列表-
- (void)userMessageListData{
    WS(weakSelf);
    SXHomeMessagePageParam *param = [SXHomeMessagePageParam param];
    self.pageIndex = 1;
    param.pageNo = @(self.pageIndex);
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMessageNetTool userMessageListParams:param.mj_keyValues Success:^(SXHomeMessageResult *result) {
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

- (void)userMessageListMoreData{
    WS(weakSelf);
    SXHomeMessagePageParam *param = [SXHomeMessagePageParam param];
    param.pageNo = @(++self.pageIndex);
    param.pageSize = @10;
    [SXMessageNetTool userMessageListParams:param.mj_keyValues Success:^(SXHomeMessageResult *result) {
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXHomeMessageCell *cell = [SXHomeMessageCell cellWithTableView:tableView];
    SXHomeMessageModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
