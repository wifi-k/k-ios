//
//  SXPhotoShareController.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareController.h"
#import "SXPhotoShareRecordController.h"
#import "SXCodeInputAlertView.h"
#import "SXPhotoShareEmptyView.h"
#import "SXPhotoShareCell.h"

@interface SXPhotoShareController ()
///空视图
@property (nonatomic, weak) SXPhotoShareEmptyView *emptyView;

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXPhotoShareController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:@"title1"];
        [_dataArray addObject:@"title2"];
        [_dataArray addObject:@"title3"];
        [_dataArray addObject:@"title4"];
        [_dataArray addObject:@"title5"];
    }
    return _dataArray;
}

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
    WS(weakSelf);
    SXCodeInputAlertView *nameAlertView = [SXCodeInputAlertView alertWithTitle:@"新建共享相册" placeholder:@"请输入相册名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf jumpToRecordVC:text];
    };
    [nameAlertView alert];
}

#pragma mark -页面跳转-
- (void)jumpToRecordVC:(NSString *)text{
    SXPhotoShareRecordController *recordVC = [[SXPhotoShareRecordController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.emptyView.hidden = self.dataArray.count;
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXPhotoShareCell *cell = [SXPhotoShareCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self jumpToRecordVC:@""];
}

@end
