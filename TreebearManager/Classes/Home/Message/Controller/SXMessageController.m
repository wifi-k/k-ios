//
//  SXMessageController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMessageController.h"
#import "SXHomeMessageCell.h"

@interface SXMessageController ()

@end

@implementation SXMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"消息中心";
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXHomeMessageCell *cell = [SXHomeMessageCell cellWithTableView:tableView];
    
#warning mark -模型赋值-
    SXHomeMessageModel *model = [SXHomeMessageModel new];
    model.title = [NSString stringWithFormat:@"标题-%ld",indexPath.row];
    model.content = [NSString stringWithFormat:@"描述-%ld",indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
