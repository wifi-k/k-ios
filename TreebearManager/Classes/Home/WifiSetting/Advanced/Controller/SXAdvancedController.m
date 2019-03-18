//
//  SXAdvancedController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAdvancedController.h"
#import "SXChannelOptionController.h"
#import "SXWorkModeOptionController.h"
#import "SXAdvancedHeaderView.h"
#import "SXFrequencyOptionController.h"

@interface SXAdvancedController ()
///头部视图
@property (nonatomic, weak) SXAdvancedHeaderView *headerView;

@property (nonatomic, strong) SXAdvancedOptionParam *optionParam;
@end

@implementation SXAdvancedController

#pragma mark -getter-
- (SXAdvancedOptionParam *)optionParam{
    if (_optionParam == nil) {
        _optionParam = [[SXAdvancedOptionParam alloc] init];
        _optionParam.selected = @0;
        _optionParam.title1 = @"title1";
        _optionParam.title2 = @"title2";
        _optionParam.title3 = @"title3";
    }
    return _optionParam;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"高级设置";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    WS(weakSelf);
    SXAdvancedHeaderView *headerView = [SXAdvancedHeaderView headerView];
    headerView.clickBgBlock = ^(NSInteger tag) {
        [weakSelf jumpToNextVC:tag];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)rightButtonAction:(UIButton *)button{
    [self jumpToVC];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)jumpToVC{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)jumpToNextVC:(NSInteger)tag{
    DLog(@"%ld",tag);
    WS(weakSelf);
    switch (tag) {
        case 1:{
            SXChannelOptionController *channelVC = [[SXChannelOptionController alloc] init];
            channelVC.selectOptionBlock = ^(NSString * _Nonnull option) {
                weakSelf.optionParam.title1 = option;
                weakSelf.headerView.param = weakSelf.optionParam;
            };
            [self.navigationController pushViewController:channelVC animated:YES];
        }
            break;
        case 2:{
            SXWorkModeOptionController *modeVC = [[SXWorkModeOptionController alloc] init];
            modeVC.selectOptionBlock = ^(NSString * _Nonnull option) {
                weakSelf.optionParam.title2 = option;
                weakSelf.headerView.param = weakSelf.optionParam;
            };
            [self.navigationController pushViewController:modeVC animated:YES];
        }
            break;
        case 3:{
            SXFrequencyOptionController *frequencyVC = [[SXFrequencyOptionController alloc] init];
            frequencyVC.selectOptionBlock = ^(NSString * _Nonnull option) {
                weakSelf.optionParam.title3 = option;
                weakSelf.headerView.param = weakSelf.optionParam;
            };
            [self.navigationController pushViewController:frequencyVC animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
