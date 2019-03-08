//
//  SXTimeControlEditController.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlEditController.h"
#import "SXDatePickerView.h"

@interface SXTimeControlEditController ()

@end

@implementation SXTimeControlEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"编辑时间";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SXDatePickerView *pickerView = [SXDatePickerView pickerView];
    [pickerView showPickerView];
}

@end
