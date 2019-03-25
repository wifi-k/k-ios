//
//  SXLoginMainController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginMainController.h"
#import "SXLoginMainHeaderView.h"
#import "SXLoginController.h"
#import "SXRegistController.h"
#import "SXMineNetTool.h"
#import "SXXiaoKiParam.h"
#import "SXRootTool.h"

@interface SXLoginMainController ()
///头部视图
@property (nonatomic, weak) SXLoginMainHeaderView *headerView;
@end

@implementation SXLoginMainController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -控制器生命周期方法-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置当前导航条背景色
//    self.navigationController.navigationBar.barTintColor = SXColorBlue2;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
//    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma -init初始化-
//- (instancetype)init{
//    if (self = [super init]) {
//        [self setUpData];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化UI
    [self setUpUI];
    
    [self setUpData];
}

- (void)setUpUI{
    
    //self.navigationItem.title = @"登录";
    
    self.view.backgroundColor = SXColorWhite;
    
    WS(weakSelf);
    SXLoginMainHeaderView *headerView = [SXLoginMainHeaderView headerView];
    headerView.clickLoginBtnBlock = ^{
        [weakSelf jumpToLoginVC];
    };
    headerView.clickRegistBtnBlock = ^{
        [weakSelf jumpToRegistVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.headerView.frame  = SXKeyWindow.bounds;
}

#pragma mark -跳转登录页面-
- (void)jumpToLoginVC{
    SXLoginController *forgetVC = [[SXLoginController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

- (void)jumpToRegistVC{
    SXRegistController *forgetVC = [[SXRegistController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark -setData(列表)-
- (void)setUpData{
    WS(weakSelf);
    [self.headerView hideIcons:YES];
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.pageNo = @1;
    param.pageSize = @10;
    [SXMineNetTool userNodeListParams:param.mj_keyValues Success:^(NSArray *array) {
        DLog(@"array:%@",array);
        if (array.count) {//列表有数据
            [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
            [SXRootTool changeToMainHomeVC];
        } else {
            [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
            [SXRootTool changeToHomeVC];
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.headerView hideIcons:NO];
        });
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
        [weakSelf.headerView hideIcons:NO];
    }];
}

@end
