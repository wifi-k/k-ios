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
@end

@implementation SXAdvancedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"高级选项";
    
    WS(weakSelf);
    SXAdvancedHeaderView *headerView = [SXAdvancedHeaderView headerView];
    headerView.clickSaveBtnBlock = ^{
        [weakSelf jumpToVC];
    };
    headerView.clickBgBlock = ^(NSInteger tag) {
        [weakSelf jumpToNextVC:tag];
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = self.view.bounds;
}

- (void)jumpToVC{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
}

- (void)jumpToNextVC:(NSInteger)tag{
    DLog(@"%ld",tag);
    switch (tag) {
        case 1:{
            SXChannelOptionController *modeVC = [[SXChannelOptionController alloc] init];
            [self.navigationController pushViewController:modeVC animated:YES];
        }
            break;
        case 2:{
            SXWorkModeOptionController *modeVC = [[SXWorkModeOptionController alloc] init];
            [self.navigationController pushViewController:modeVC animated:YES];
        }
            break;
        case 3:{
            SXFrequencyOptionController *modeVC = [[SXFrequencyOptionController alloc] init];
            [self.navigationController pushViewController:modeVC animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
