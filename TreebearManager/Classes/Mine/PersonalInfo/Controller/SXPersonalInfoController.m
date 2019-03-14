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
#import "SXForgetConfirmController.h"
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
        [weakSelf clickIconBgView];
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

#pragma mark -Event-
- (void)clickIconBgView{
    DLog(@"clickIconBgView");
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
    SXForgetConfirmController *forgetVC = [[SXForgetConfirmController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

@end
