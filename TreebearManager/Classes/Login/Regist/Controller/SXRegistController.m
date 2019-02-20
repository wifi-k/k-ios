//
//  SXRegistController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXRegistController.h"
#import "SXRegistHeaderView.h"

@interface SXRegistController ()
///头部视图
@property (nonatomic, weak) SXRegistHeaderView *headerView;
@end

@implementation SXRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpUI];
}
    
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    WS(weakSelf);
    SXRegistHeaderView *headerView = [SXRegistHeaderView headerView];
    headerView.clickRegistBlock = ^{
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
