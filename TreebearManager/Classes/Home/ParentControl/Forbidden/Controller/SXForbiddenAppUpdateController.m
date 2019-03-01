//
//  SXForbiddenAppUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppUpdateController.h"
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
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"新增";
    
    WS(weakSelf);
    SXForbiddenUpdateHeaderView *headerView = [SXForbiddenUpdateHeaderView headerView];
    headerView.clickTimeControlBlock = ^{
        DLog(@"商检clickTimeControlBlock");
    };
    headerView.clickDeviceControlBlock = ^{
        DLog(@"商检clickDeviceControlBlock");
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
