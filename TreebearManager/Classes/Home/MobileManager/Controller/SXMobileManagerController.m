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
//    WS(weakSelf);
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 80.0;
//    } else{
//        return 50.0f;
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *sectionHeaderV = nil;
//    if (section == 0) {
//        SXHomeMainSectionHeaderView *headerView = [SXHomeMainSectionHeaderView headerViewWithTableView:tableView];
//        sectionHeaderV = headerView;
//    } else {
//        SXHomeMainSectionHeaderView2 *headerView = [SXHomeMainSectionHeaderView2 headerViewWithTableView:tableView];
//        sectionHeaderV = headerView;
//    }
//    return sectionHeaderV;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 1) {
//        return 230.0f;
//    } else if (section == 0){
//        return 80.0f;
//    }
//    return 0.01;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    WS(weakSelf);
//    if (section == 1) {
//        SXHomeMainSectionFooterView2 *footerView = [SXHomeMainSectionFooterView2 footerView];
//        footerView.clickReportBtnBlock = ^{
//            SXHomeReportController *reportVC = [[SXHomeReportController alloc] init];
//            [weakSelf.navigationController pushViewController:reportVC animated:YES];
//        };
//        return footerView;
//    } else {
//        SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
//        footerView.clickMoreBtnBlock = ^{
//            SXMobileManagerController *mobileManagerVC = [[SXMobileManagerController alloc] init];
//            [weakSelf.navigationController pushViewController:mobileManagerVC animated:YES];
//        };
//        return footerView;
//    }
//    return [[UIView alloc] initWithFrame:CGRectZero];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
