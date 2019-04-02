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
#import "SXXiaoKiOptionResult.h"
#import "SXParentControlNetTool.h"

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
        addModel.name = @"新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增";
        headerView.model = addModel;
        self.model = addModel;
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
    if (self.selectForbiddenOptionBlock) {
        self.selectForbiddenOptionBlock(self.model);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf userNodeDeviceAllowSetData:text];
    };
    [nameAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpForbiddenAppOptionVC{
    WS(weakSelf);
    SXForbiddenAppOptionController *appVC = [[SXForbiddenAppOptionController alloc] init];
    appVC.selectForbiddenOptionBlock = ^(NSString * _Nonnull model) {
        weakSelf.model.name = model;
        weakSelf.headerView.model = weakSelf.model;
    };
    [self.navigationController pushViewController:appVC animated:YES];
}

- (void)jumpToDeviceVC{
    WS(weakSelf);
    SXForbiddenDeviceOptionController *deviceVC = [[SXForbiddenDeviceOptionController alloc] init];
    deviceVC.selectForbiddenOptionBlock = ^(NSString * _Nonnull model) {
        weakSelf.model.name = model;
        weakSelf.headerView.model = weakSelf.model;
    };
    [self.navigationController pushViewController:deviceVC animated:YES];
}

#pragma mark -设置设备允许上网配置接口-
- (void)userNodeDeviceAllowSetData:(NSString *)text{
    WS(weakSelf);
    SXForbiddenAppParam *param = [SXForbiddenAppParam param];
    param.nodeId = self.model.nodeId;
    param.modelId = self.model.modelId;
    param.name = text;
    [SXParentControlNetTool userNodeDeviceAllowSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        
        //更改赋值
        weakSelf.model.name = text;
        [weakSelf.headerView setUpData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
