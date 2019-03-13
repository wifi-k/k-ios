//
//  SXMineSettingController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineSettingController.h"
#import "SXMineAboutUsController.h"
#import "SXMineVersionUpdateController.h"
#import "SXMineSettingHeaderView.h"

@interface SXMineSettingController ()
@property (nonatomic, weak) SXMineSettingHeaderView *headerView;//头部视图
@end

@implementation SXMineSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.navigationItem.title = @"设置";
    
    self.view.backgroundColor = SXColorWhite;
    
    //2.头部视图
    WS(weakSelf);
    SXMineSettingHeaderView *headerView = [SXMineSettingHeaderView headerView];
    headerView.clickAboutUsBlock = ^{
        SXMineAboutUsController *aboutVC = [[SXMineAboutUsController alloc] init];
        [weakSelf.navigationController pushViewController:aboutVC animated:YES];
    };
    headerView.clickUpdateVersionBlock = ^{
        SXMineVersionUpdateController *updateVC = [[SXMineVersionUpdateController alloc] init];
        [weakSelf.navigationController pushViewController:updateVC animated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}


@end
