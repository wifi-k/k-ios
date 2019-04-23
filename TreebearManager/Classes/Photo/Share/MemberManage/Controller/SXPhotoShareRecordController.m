//
//  SXPhotoShareRecordController.m
//  TreebearManager
//
//  Created by bear on 2019/4/23.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareRecordController.h"
#import "SXPhotoShareRecordHeaderView.h"

@interface SXPhotoShareRecordController ()

///添加字段
@property (nonatomic, weak) SXPhotoShareRecordHeaderView *headerView;
@end

@implementation SXPhotoShareRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"时光匆匆";
    
    //头部视图
    SXPhotoShareRecordHeaderView *headerView = [SXPhotoShareRecordHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

#pragma mark - Layout -
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
}

@end
