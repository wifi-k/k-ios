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
#import "SXWifiSettingNetTool.h"

@interface SXMobileDetailController ()
@property (nonatomic, weak) SXMobileDetailHeaderView *headerView;//头部视图
@end

@implementation SXMobileDetailController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -life recycle-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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
    headerView.model = self.model;
    headerView.clickBackBtnBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    headerView.clickCenterFirstBgViewBlock = ^{
        [weakSelf jumpToMobileInfoVC];
    };
    headerView.clickEditBtnBlock = ^{
        [weakSelf alertRemarkNameView];
    };
    self.tableView.contentInset = UIEdgeInsetsMake(-22-iPhoneX_top, 0, 0, 0);
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
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 780);
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
    infoVC.model = self.model;
    [self.navigationController pushViewController:infoVC animated:YES];
}

#pragma mark -修改设备信息-
- (void)userDodeDeviceSetData{
    SXMobilePageParam *param = [SXMobilePageParam param];
    param.nodeId = @"";
    param.mac = @"";
    param.note = @"";
    param.isBlock = @0;
    param.isRecord = @1;
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

@end
