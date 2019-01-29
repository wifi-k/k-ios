//
//  SXBaseTableViewGroupController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseTableViewGroupController.h"
#import <UIScrollView+EmptyDataSet.h>

@interface SXBaseTableViewGroupController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation SXBaseTableViewGroupController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建tableView
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = SXColorBgViewGray;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
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
