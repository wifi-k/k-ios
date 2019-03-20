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
    SXCodeInputAlertView *nameAlertView = [SXCodeInputAlertView alertWithTitle:@"重命名" placeholder:@"请输入新的名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [SXRootTool changeToMainHomeVC];
    };
    [nameAlertView alert];
}

@end
