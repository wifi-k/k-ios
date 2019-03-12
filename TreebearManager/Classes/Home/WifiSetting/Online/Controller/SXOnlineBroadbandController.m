//
//  SXOnlineBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandController.h"
#import "SXOnlineBroadbandHeaderView.h"

@interface SXOnlineBroadbandController ()
///头部视图
@property (nonatomic, weak) SXOnlineBroadbandHeaderView *headerView;
@end

@implementation SXOnlineBroadbandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"宽带拨号上网";
}

@end
