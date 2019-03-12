//
//  SXOnlineAutotIPController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineAutotIPController.h"
#import "SXOnlineAutotIPHeaderView.h"

@interface SXOnlineAutotIPController ()
///头部视图
@property (nonatomic, weak) SXOnlineAutotIPHeaderView *headerView;
@end

@implementation SXOnlineAutotIPController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorRandom;
    
    //self.navigationItem.title = @"自动获取IP地址";
}


@end
