//
//  SXMineController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineController.h"
#import "SXMineListCell.h"
#import "SXRootTool.h"
#import "SXMineHeaderView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "SXMineNetTool.h"

@interface SXMineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXMineHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图
@end

@implementation SXMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //用户信息获取
    [self getUserinfoData];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"我的";
    
    //1.创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = SXColorBgViewGray;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    //2.头部视图
    WS(weakSelf);
    SXMineHeaderView *headerView = [SXMineHeaderView headerView];
    headerView.clickBindingBtnBlock = ^{
        [weakSelf jumpToImagePickerVC];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
     self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
}

#pragma mark -获取用户信息-
- (void)getUserinfoData{
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMineNetTool getUserInfoDataSuccess:^(SXMineUserInfoModel * _Nonnull model) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"model:%@",model);
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)jumpToImagePickerVC{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        DLog(@"photos:%@,",photos);
        DLog(@"assets:%@,",assets);
        DLog(@"isSelectOriginalPhoto:%d,",isSelectOriginalPhoto);
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXMineListCell *cell = [SXMineListCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [SXRootTool chooseRootWithLoginVC:SXDelegateWindow];
}

@end
