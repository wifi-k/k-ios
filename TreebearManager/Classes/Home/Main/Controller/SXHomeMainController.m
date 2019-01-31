//
//  SXHomeConnectedController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainController.h"
#import "SXRootTool.h"

@interface SXHomeMainController ()

@end

@implementation SXHomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    self.navigationItem.title = @"首页";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DLog(@"SXHomeConnectedController");
    
    [SXRootTool changeToHomeVC];
}
    
@end
