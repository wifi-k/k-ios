//
//  SXBaseCustomTablePlainRrfreshController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTablePlainRrfreshController.h"
#import "SXRefreshFooter.h"

@interface SXBaseCustomTablePlainRrfreshController ()

@end

@implementation SXBaseCustomTablePlainRrfreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加下拉刷新
    WS(weakSelf);
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf dropRefresh];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    //2.添加上拉加载
    self.tableView.mj_footer = [SXRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf pullRefresh];
    }];
}
    
#pragma mark -开始刷新动画-
-(void)refresh{
    [self.tableView.mj_header beginRefreshing];//自动下拉刷新
}
    
#pragma mark -下拉动画-
- (void)dropRefresh{
    DLog(@"dropRefresh");
}
    
#pragma mark -上拉动画-
- (void)pullRefresh{
    DLog(@"pullRefresh");
}
    
#pragma mark -停止刷新动画-
- (void)endHeaderRefresh{
    DLog(@"endHeaderRefresh");
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
    
#pragma mark -停止刷新动画-
- (void)endFooterRefresh{
    DLog(@"endHeaderRefresh");
    [self.tableView.mj_footer endRefreshing];
}
    
#pragma mark -已经到底-
- (void)showNoMoreDataFooterView{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

@end
