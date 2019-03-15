//
//  SXMobileDetailController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMobileDetailController.h"
#import "SXMobileInfoController.h"
#import "SXMobileDetailHeaderView.h"
#import "SXInputAlertView.h"

@interface SXMobileDetailController ()
@property (nonatomic, weak) SXMobileDetailHeaderView *headerView;//头部视图
@end

@implementation SXMobileDetailController

#pragma mark -life recycle-
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    //设置当前导航条背景色
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    //设置当前导航条背景色
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"设备详情";
    
    WS(weakSelf);
    SXMobileDetailHeaderView *headerView = [SXMobileDetailHeaderView headerView];
    headerView.clickCenterFirstBgViewBlock = ^{
        [weakSelf jumpToMobileInfoVC];
    };
    headerView.clickEditBtnBlock = ^{
        [weakSelf alertRemarkNameView];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//
//    self.tableView.frame = SXKeyWindow.bounds;
//}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 750);
}

#pragma mark -弹窗视图-
- (void)alertRemarkNameView{
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -点击事件-
- (void)jumpToMobileInfoVC{
    SXMobileInfoController *infoVC = [[SXMobileInfoController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
