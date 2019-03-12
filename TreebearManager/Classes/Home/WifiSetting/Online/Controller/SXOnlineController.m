//
//  SXOnlineController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineController.h"
#import "SXOnlineOptionHeaderView.h"
#import "SXDropDownMenu.h"

@interface SXOnlineController ()<SXDropDownMenuDelegate>
///头部视图
@property (nonatomic, weak) SXOnlineOptionHeaderView *headerView;

@end

@implementation SXOnlineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"上网设置";
    
    WS(weakSelf);
    SXOnlineOptionHeaderView *headerView = [SXOnlineOptionHeaderView headerView];
    headerView.clickOptionBtnBlock = ^{
        DLog(@"菜单。。。");
        [weakSelf dropDownMenu];
    };
    headerView.backgroundColor = SXColorRandom;
    [self.view addSubview:headerView];
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
}

- (void)dropDownMenu{
    NSArray *titles = @[@"自动获取IP地址",@"固定IP地址",@"宽带拨号上网"];
    SXDropDownMenu *dropDownMenu = [SXDropDownMenu dropMenu];
    [dropDownMenu showDropDownMenuWithButtonFrame:self.headerView.menuBtn.frame arrayOfTitle:titles];
    dropDownMenu.delegate = self;
    [self.view addSubview:dropDownMenu];
}

#pragma mark -SXDropDownMenuDelegate-
- (void)popDropMenu:(SXDropDownMenu *)popView row:(NSInteger)row{
    DLog(@"row:%ld",row);
    
}

@end
