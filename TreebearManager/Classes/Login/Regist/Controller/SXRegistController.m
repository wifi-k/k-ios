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
 
    self.view.backgroundColor = SXColorRandom;
    
    [self setUpUI];
}
    
- (void)setUpUI{
    SXRegistHeaderView *headerView = [SXRegistHeaderView headerView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
}
    
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

@end
