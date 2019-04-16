//
//  SXBaseCustomTableViewGroupController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTableViewGroupController.h"
#import <UIScrollView+EmptyDataSet.h>

@interface SXBaseCustomTableViewGroupController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation SXBaseCustomTableViewGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = SXColorWhite;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //设置代理
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - DZNEmptyDataSetSource/DZNEmptyDataSetDelegate
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyDataView;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

@end
