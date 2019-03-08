//
//  SXTimeControlAddController.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlAddController.h"
#import "SXTimeControlEditController.h"
#import "SXTimeControlAddCell.h"
#import "SXTitleAlertView.h"

@interface SXTimeControlAddController ()

@end

@implementation SXTimeControlAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"允许上网时间段";
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVC{
    SXTimeControlEditController *editVC = [[SXTimeControlEditController alloc] init];
    editVC.selectTimeBlock = ^{
        DLog(@"选中了时间");
    };
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView{
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此方案吗?" confirmStr:@"确定" cancelStr:@"取消"];
    deleteAlertView.confirmButtonBlock = ^{
        DLog(@"确定。。。");
    };
    [deleteAlertView alert];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXTimeControlAddCell *cell = [SXTimeControlAddCell cellWithTableView:tableView];
    cell.clickEditBtnBlock = ^{
        [weakSelf jumpToUpdateVC];
    };
    cell.clickDeleteBtnBlock = ^{
        [weakSelf alertDeleteAlertView];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
