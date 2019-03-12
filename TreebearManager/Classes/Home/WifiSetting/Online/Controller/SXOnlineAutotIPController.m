//
//  SXOnlineAutotIPController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineAutotIPController.h"
#import "SXAdvancedOptionController.h"
#import "SXOnlineAutotIPHeaderView.h"

@interface SXOnlineAutotIPController ()
///头部视图
@property (nonatomic, weak) SXOnlineAutotIPHeaderView *headerView;
@end

@implementation SXOnlineAutotIPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorRandom;
    
    //self.navigationItem.title = @"自动获取IP地址";
    WS(weakSelf);
    SXOnlineAutotIPHeaderView *headerView = [SXOnlineAutotIPHeaderView headerView];
    headerView.clickUpdateIPBtnBlock = ^{
        DLog(@"菜单。。。");
        [MBProgressHUD showMessage:@"更新成功！" toView:self.view];
    };
    headerView.clickAdvancedBgViewBlock = ^{
        [weakSelf jumpToOptionVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -点击事件-
- (void)jumpToOptionVC{
    SXAdvancedOptionController *optionVC = [[SXAdvancedOptionController alloc] init];
    [self.navigationController pushViewController:optionVC animated:YES];
}

@end
