//
//  SXNickNameUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNickNameUpdateController.h"
#import "SXNickNameUpdateHeaderView.h"
#import "SXMineNetTool.h"

@interface SXNickNameUpdateController ()
@property (nonatomic, weak) SXNickNameUpdateHeaderView *headerView;//头部视图
@end

@implementation SXNickNameUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"昵称";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"完成" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    //2.头部视图
    SXNickNameUpdateHeaderView *headerView = [SXNickNameUpdateHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -Event-
- (void)rightButtonAction:(UIButton *)btn{
    DLog(@"btn:%@",btn.titleLabel.text);
    
    [self userInfoSetData];
}

- (void)userInfoSetData{
    if ([NSString isEmpty:self.headerView.param.name]) {
        [MBProgressHUD showFailWithMessage:@"昵称修改不能为空" toView:SXKeyWindow];
        return;
    }
    WS(weakSelf);
    SXMineUserInfoParam *param = [SXMineUserInfoParam param];
    param.name = self.headerView.param.name;
    [SXMineNetTool userInfoSetParams:param.mj_keyValues Success:^{
        [MBProgressHUD showSuccessWithMessage:@"OK！" toView:SXKeyWindow];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

@end
