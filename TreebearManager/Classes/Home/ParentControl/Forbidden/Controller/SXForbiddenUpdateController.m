//
//  SXForbiddenAppUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenUpdateController.h"
#import "SXForbiddenDeviceOptionController.h"
#import "SXForbiddenAppOptionController.h"
#import "SXForbiddenUpdateHeaderView.h"
#import "SXWifiSettingAlertView.h"

@interface SXForbiddenUpdateController ()
///头部视图
@property (nonatomic, weak) SXForbiddenUpdateHeaderView *headerView;
@end

@implementation SXForbiddenUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorBgViewGray;
    
    BOOL isAdd = (self.model == nil? YES:NO);
    if (isAdd) {
        self.navigationItem.title = @"新增";
    } else{
        self.navigationItem.title = @"编辑";
    }
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    WS(weakSelf);
    SXForbiddenUpdateHeaderView *headerView = [SXForbiddenUpdateHeaderView headerView];
    if (isAdd) {
        SXForbiddenAppModel *addModel = [[SXForbiddenAppModel alloc] init];
        headerView.model = addModel;
    } else {
        headerView.model = self.model;
    }
    headerView.model = self.model;
    headerView.clickUpdateNameBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickForbiddenAppBlock = ^{
        [weakSelf jumpForbiddenAppOptionVC];
    };
    headerView.clickDeviceControlBlock = ^{
        [weakSelf jumpToDeviceVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)button{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpToDeviceVC{
    WS(weakSelf);
    SXForbiddenDeviceOptionController *deviceVC = [[SXForbiddenDeviceOptionController alloc] init];
    deviceVC.selectForbiddenOptionBlock = ^(NSString * _Nonnull model) {
        weakSelf.model.content2 = model;
        weakSelf.headerView.model = weakSelf.model;
    };
    [self.navigationController pushViewController:deviceVC animated:YES];
}

- (void)jumpForbiddenAppOptionVC{
    WS(weakSelf);
    SXForbiddenAppOptionController *appVC = [[SXForbiddenAppOptionController alloc] init];
    appVC.selectForbiddenOptionBlock = ^(NSString * _Nonnull model) {
        weakSelf.model.content1 = model;
        weakSelf.headerView.model = weakSelf.model;
    };
    [self.navigationController pushViewController:appVC animated:YES];
}

@end
