//
//  SXOnlineBroadbandController.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineBroadbandController.h"

@interface SXOnlineBroadbandController ()

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
