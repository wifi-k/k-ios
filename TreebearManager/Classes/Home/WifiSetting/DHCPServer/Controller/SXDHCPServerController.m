//
//  SXDHCPServerController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDHCPServerController.h"
#import "SXDHCPServerHeaderView.h"

@interface SXDHCPServerController ()
///头部视图
@property (nonatomic, weak) SXDHCPServerHeaderView *headerView;
@end

@implementation SXDHCPServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"DHCP服务器";

//    WS(weakSelf);
    SXDHCPServerHeaderView *headerView = [SXDHCPServerHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
