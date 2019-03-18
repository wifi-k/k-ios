//
//  SXForbiddenDeviceOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenDeviceOptionController.h"
#import "SXForbiddenDeviceOptionCell.h"

@interface SXForbiddenDeviceOptionController ()

@end

@implementation SXForbiddenDeviceOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"选择禁用的设备";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)button{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    if (self.selectForbiddenOptionBlock) {
        NSString *fdfdf = [NSString stringWithFormat:@"%@个",10];
        self.selectForbiddenOptionBlock(fdfdf);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXForbiddenDeviceOptionCell *cell = [SXForbiddenDeviceOptionCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
