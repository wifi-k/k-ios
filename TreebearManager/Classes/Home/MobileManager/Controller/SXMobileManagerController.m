//
//  SXMobileManagerController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileManagerController.h"
#import "SXMobileDetailController.h"
#import "SXMobileManagerHeaderView.h"
#import "SXMobileManagerCell.h"
#import "SXInputAlertView.h"

@interface SXMobileManagerController ()
@property (nonatomic, weak) SXMobileManagerHeaderView *headerView;//头部视图
@end

@implementation SXMobileManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"连网设备";
    
    //2.头部视图
    SXMobileManagerHeaderView *headerView = [SXMobileManagerHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
}

#pragma mark -弹窗视图-
- (void)alertRemarkNameView{
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXMobileManagerCell *cell = [SXMobileManagerCell cellWithTableView:tableView];
    cell.clickRemarkBtnBlock = ^{
        [weakSelf alertRemarkNameView];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
