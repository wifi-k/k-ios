//
//  SXPersonalInfoController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPersonalInfoController.h"
#import "SXNickNameUpdateController.h"
#import "SXMobileUpdateController.h"
#import "SXPersonalInfoHeaderView.h"

@interface SXPersonalInfoController ()
@property (nonatomic, weak) SXPersonalInfoHeaderView *headerView;//头部视图
@end

@implementation SXPersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"个人信息";
    
    //2.头部视图
    WS(weakSelf);
    SXPersonalInfoHeaderView *headerView = [SXPersonalInfoHeaderView headerView];
    headerView.clickIconBgViewBlock = ^{
        [weakSelf fdfdfdf];
    };
    headerView.clickNickNameBgViewBlock = ^{
        [weakSelf jumpToNickNameVC];
    };
    headerView.clickMobileBgViewBlock = ^{
        [weakSelf jumpToMobileVC];
    };
    headerView.clickPasswordBgViewBlock = ^{
        [weakSelf jumpToPasswordVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)fdfdfdf{
    [MBProgressHUD showMessage:@"相册" toView:self.view];
}

- (void)jumpToNickNameVC{
    SXNickNameUpdateController *nickVC = [[SXNickNameUpdateController alloc] init];
    [self.navigationController pushViewController:nickVC animated:YES];
}

- (void)jumpToMobileVC{
    SXMobileUpdateController *mobileVC = [[SXMobileUpdateController alloc] init];
    [self.navigationController pushViewController:mobileVC animated:YES];
}

- (void)jumpToPasswordVC{
    [MBProgressHUD showMessage:@"jumpToPasswordVC" toView:self.view];
}

@end
