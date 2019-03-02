//
//  SXForbiddenAppController.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppController.h"
#import "SXForbiddenAppUpdateController.h"
#import "SXForbiddenAppFooterView.h"
#import "SXForbiddenAppCell.h"
#import "SXTitleAlertView.h"

@interface SXForbiddenAppController ()

@end

@implementation SXForbiddenAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"禁用";
    
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
        [weakSelf jumpToUpdateVC];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView{
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此方案吗?" confirmStr:@"确定" cancelStr:@"取消"];
    [deleteAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVC{
    SXForbiddenAppUpdateController *updateVC = [[SXForbiddenAppUpdateController alloc] init];
    [self.navigationController pushViewController:updateVC animated:YES];
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
    SXForbiddenAppCell *cell = [SXForbiddenAppCell cellWithTableView:tableView];
    cell.title = [NSString stringWithFormat:@"禁用APP方案%ld",indexPath.row];
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
