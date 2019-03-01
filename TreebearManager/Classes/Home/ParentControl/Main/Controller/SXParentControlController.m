//
//  SXParentControlController.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXParentControlController.h"
#import "SXForbiddenAppController.h"
#import "SXTimeControlController.h"
#import "SXParentControlHeaderView.h"

@interface SXParentControlController ()
///头部视图
@property (nonatomic, weak) SXParentControlHeaderView *headerView;
@end

@implementation SXParentControlController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"家长控制";
    
    WS(weakSelf);
    SXParentControlHeaderView *headerView = [SXParentControlHeaderView headerView];
    headerView.clickForbiddenAppBlock = ^{
        [weakSelf jumpToForbiddenAppVC];
    };
    headerView.clickTimeControlBlock = ^{
        [weakSelf jumpToTimeControlVC];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

#pragma mark -页面跳转-
- (void)jumpToForbiddenAppVC{
    SXForbiddenAppController *forbiddenVC = [[SXForbiddenAppController alloc] init];
    [self.navigationController pushViewController:forbiddenVC animated:YES];
}

- (void)jumpToTimeControlVC{
    SXTimeControlController *forbiddenVC = [[SXTimeControlController alloc] init];
    [self.navigationController pushViewController:forbiddenVC animated:YES];
}

@end
