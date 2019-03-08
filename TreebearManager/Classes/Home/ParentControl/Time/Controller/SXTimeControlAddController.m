//
//  SXTimeControlAddController.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlAddController.h"
#import "SXTimeControlEditController.h"

@interface SXTimeControlAddController ()

@end

@implementation SXTimeControlAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"允许上网时间段";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SXTimeControlEditController *editVC = [[SXTimeControlEditController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

@end
