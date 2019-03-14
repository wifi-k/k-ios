//
//  SXNickNameUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNickNameUpdateController.h"
#import "SXNickNameUpdateHeaderView.h"

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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
