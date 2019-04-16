//
//  SXTimeUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeUpdateController.h"
#import "SXForbiddenDeviceOptionController.h"
#import "SXTimeControlEditController.h"
#import "SXTimeUpdateHeaderView.h"
#import "SXWifiSettingAlertView.h"
#import "SXXiaoKiOptionResult.h"
#import "SXParentControlNetTool.h"

@interface SXTimeUpdateController ()
///头部视图
@property (nonatomic, weak) SXTimeUpdateHeaderView *headerView;
@end

@implementation SXTimeUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    BOOL isAdd = (self.model == nil? YES:NO);
    if (isAdd) {
        self.navigationItem.title = @"新增";
    } else{
        self.navigationItem.title = @"编辑";
    }
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    WS(weakSelf);
    SXTimeUpdateHeaderView *headerView = [SXTimeUpdateHeaderView headerView];
    if (isAdd) {
        SXTimeControlModel *addModel = [[SXTimeControlModel alloc] init];
        SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
        addModel.modelId = @"0";
        addModel.nodeId = model.nodeId;
        addModel.name = @"上网时间控制";
        headerView.model = addModel;
        self.model = addModel;
    } else {
        headerView.model = self.model;
    }
    headerView.model = self.model;
    headerView.clickUpdateNameBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickTimeControlAppBlock = ^{
        [weakSelf jumpTimeControlVC];
    };
    headerView.clickDeviceControlBlock = ^{
        [weakSelf jumpToDeviceVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)rightButtonAction:(UIButton *)button{
    [self userNodeDeviceAllowSetData];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXWifiSettingAlertView *nameAlertView = [SXWifiSettingAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        //更改赋值
        weakSelf.model.name = text;
        [weakSelf.headerView setUpData];
    };
    [nameAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpTimeControlVC{
    WS(weakSelf);
    SXTimeControlEditController *timeVC = [[SXTimeControlEditController alloc] init];
    timeVC.model = self.model;
    timeVC.selectTimeBlock = ^(SXTimeControlParam * _Nonnull param) {
        weakSelf.model.st = param.st;
        weakSelf.model.et = param.et;
        weakSelf.model.wt = param.wt;
        weakSelf.headerView.model = weakSelf.model;
        [weakSelf.headerView selectTime];
    };
    [self.navigationController pushViewController:timeVC animated:YES];
}

- (void)jumpToDeviceVC{
    WS(weakSelf);
    SXForbiddenDeviceOptionController *deviceVC = [[SXForbiddenDeviceOptionController alloc] init];
    deviceVC.selectForbiddenOptionBlock = ^(NSArray * _Nonnull selectedList) {
        weakSelf.model.mac = selectedList;
        weakSelf.headerView.model = weakSelf.model;
        [weakSelf.headerView selectDevice];
    };
    [self.navigationController pushViewController:deviceVC animated:YES];
}

#pragma mark -设置设备允许上网配置接口-
- (void)userNodeDeviceAllowSetData{
    
    if (![self.headerView isSelectedAll]) {
        [MBProgressHUD showWarningWithMessage:@"时间和设备选择缺一不可!" toView:SXKeyWindow];
        return;
    }
    
    WS(weakSelf);
    SXForbiddenAppParam *param = [SXForbiddenAppParam param];
    param.nodeId = self.model.nodeId;
    param.modelId = self.model.modelId;
    param.name = self.model.name;
    param.mac = self.model.mac;
    param.st = self.model.st;
    param.et = self.model.et;
    param.wt = self.model.wt;
    [SXParentControlNetTool userNodeDeviceAllowSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"设置成功!" toView:SXKeyWindow];
        
        if (weakSelf.selectTimeControlOptionBlock) {
            weakSelf.selectTimeControlOptionBlock(weakSelf.model);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

@end
