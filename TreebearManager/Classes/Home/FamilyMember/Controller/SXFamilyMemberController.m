//
//  SXFamilyMemberController.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberController.h"
#import "SXFamilyMemberFooterView.h"
#import "SXFamilyMemberCell.h"
#import "SXWifiSettingAlertView.h"
#import "SXTitleAlertView.h"

@interface SXFamilyMemberController ()

@end

@implementation SXFamilyMemberController

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
    
    self.navigationItem.title = @"家庭成员";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
    WS(weakSelf);
    SXFamilyMemberFooterView *footerView = [SXFamilyMemberFooterView
                                            footerView];
    footerView.clickAddMemberBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView{
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此成员吗?" confirmStr:@"确定" cancelStr:@"取消"];
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
    SXFamilyMemberCell *cell = [SXFamilyMemberCell cellWithTableView:tableView];
    cell.clickAddBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    cell.clickEditBtnBlock = ^{
        [weakSelf alertUpdateNameView];
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
