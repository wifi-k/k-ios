//
//  SXHomeController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeController.h"
#import "SXFamilyMemberController.h"
#import "SXAddXiaoKiController.h"
#import "SXRootTool.h"
#import "SXHomeHeaderView.h"
#import "SXCodeInputAlertView.h"
#import "SXFamilyMemberNetTool.h"

@interface SXHomeController ()
///头部视图
@property (nonatomic, weak) SXHomeHeaderView *headerView;
    
@end

@implementation SXHomeController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -控制器生命周期方法-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = [UIColor hex:@"444652"];
    self.navigationController.navigationBar.hidden = YES;
}
    
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    //self.navigationController.navigationBar.barTintColor = UIColor.blueColor;
    self.navigationController.navigationBar.hidden = NO;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"首页";
    
    WS(weakSelf);
    SXHomeHeaderView *headerView = [SXHomeHeaderView headerView];
    headerView.clickBindingBtnBlock = ^{
        [weakSelf addXiaoKiVC];
    };
    headerView.clickFamilyCodeBtnBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    headerView.clickProductBtnBlock = ^{
        DLog(@"点击产品页面...");
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
 
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -页面跳转-
- (void)addXiaoKiVC{
    SXAddXiaoKiController *addVC = [[SXAddXiaoKiController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXCodeInputAlertView *nameAlertView = [SXCodeInputAlertView alertWithTitle:@"提示" placeholder:@"请输家庭码" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf userNodeFamilyJoin:text];
    };
    [nameAlertView alert];
}

- (void)userNodeFamilyJoin:(NSString *)text{
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    param.inviteCode = text;
    [SXFamilyMemberNetTool userNodeFamilyJoinDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"添加成功!" toView:SXKeyWindow];
        [SXRootTool changeToMainHomeVC];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
#warning mark -测试使用-
        [SXRootTool changeToMainHomeVC];
    }];
}

@end
