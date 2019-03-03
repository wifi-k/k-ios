//
//  SXXiaoKiController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiController.h"
#import "SXUpdateVersionController.h"
#import "SXHomeXiaoKiCell.h"
#import "SXInputAlertView.h"
#import "SXTitleAlertView.h"

@interface SXXiaoKiController ()

@end

@implementation SXXiaoKiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"我的小K";
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -弹窗视图-
- (void)alertUpdateNameView{
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"修改名称" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

- (void)alertUnbindAV{
    SXTitleAlertView *unbindAV = [SXTitleAlertView alertWithTitle:@"解绑小k" content:@"是否确定解绑小k管家-8341?" confirmStr:@"确定" cancelStr:@"取消"];
    unbindAV.confirmButtonBlock = ^{
        DLog(@"确定...");
    };
    [unbindAV alert];
}

#pragma mark -页面跳转-
- (void)jumpToUpdateVersionVC{
    SXUpdateVersionController *updateVC = [[SXUpdateVersionController alloc] init];
    [self.navigationController pushViewController:updateVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXHomeXiaoKiCell *cell = [SXHomeXiaoKiCell cellWithTableView:tableView];
    cell.clickUpdateNameBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    cell.clickUnbindBtnBlock = ^{
        [weakSelf alertUnbindAV];
    };
    cell.clickUpdateVersionBtnBlock = ^{
        [weakSelf jumpToUpdateVersionVC];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
