//
//  SXMineVersionUpdateController.m
//  TreebearManager
//
//  Created by bear on 2019/3/13.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineVersionUpdateController.h"
#import "SXMineVersionUpdateHeaderView.h"

@interface SXMineVersionUpdateController ()
@property (nonatomic, weak) SXMineVersionUpdateHeaderView *headerView;//头部视图
@end

@implementation SXMineVersionUpdateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"版本更新";
    
    self.view.backgroundColor = SXColorWhite;
    
    //2.头部视图
    WS(weakSelf);
    SXMineVersionUpdateHeaderView *headerView = [SXMineVersionUpdateHeaderView headerView];
//    headerView.clickBindingBtnBlock = ^{
//        [weakSelf jumpToImagePickerVC];
//    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
