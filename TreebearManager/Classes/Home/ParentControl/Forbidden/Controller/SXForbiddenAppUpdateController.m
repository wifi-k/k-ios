//
//  SXForbiddenAppUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppUpdateController.h"
#import "SXDeviceControlController.h"
#import "SXForbiddenUpdateHeaderView.h"

@interface SXForbiddenAppUpdateController ()
///头部视图
@property (nonatomic, weak) SXForbiddenUpdateHeaderView *headerView;
@end

@implementation SXForbiddenAppUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}



#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorBgViewGray;
    
    self.navigationItem.title = @"新增";
    
    WS(weakSelf);
    SXForbiddenUpdateHeaderView *headerView = [SXForbiddenUpdateHeaderView headerView];
    headerView.clickTimeControlBlock = ^{
        [weakSelf jumpTofdfdf];
    };
    headerView.clickDeviceControlBlock = ^{
        [weakSelf jumpTofdfdf];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)jumpTofdfdf{
    SXDeviceControlController *fdf = [[SXDeviceControlController alloc] init];
    [self.navigationController pushViewController:fdf animated:YES];
}

@end
