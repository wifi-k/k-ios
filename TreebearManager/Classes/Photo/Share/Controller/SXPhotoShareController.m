//
//  SXPhotoShareController.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareController.h"
#import "SXCodeInputAlertView.h"
#import "SXPhotoShareEmptyView.h"

@interface SXPhotoShareController ()

///空视图
@property (nonatomic, weak) SXPhotoShareEmptyView *emptyView;

@end

@implementation SXPhotoShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"共享相册";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"img_share_add_topright"] highImage:[UIImage imageNamed:@"img_share_add_topright"] target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    //空视图
    SXPhotoShareEmptyView *emptyView = [SXPhotoShareEmptyView emptyView];
    emptyView.frame = self.view.bounds;
    [self.view addSubview:emptyView];
    self.emptyView = emptyView;
}

#pragma mark -Event-
- (void)rightButtonAction:(UIButton *)btn{
    
    SXCodeInputAlertView *nameAlertView = [SXCodeInputAlertView alertWithTitle:@"新建共享相册" placeholder:@"请输入相册名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        
    };
    [nameAlertView alert];
}

@end
