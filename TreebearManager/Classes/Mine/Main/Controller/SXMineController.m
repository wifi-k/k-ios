//
//  SXMineController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineController.h"

@interface SXMineController ()

@end

@implementation SXMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    self.navigationItem.title = @"我的";
    
     DLog(@"-SXMineController-");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SXMineController *homeVC = [[SXMineController alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
}

@end
