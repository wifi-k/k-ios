//
//  SXMineController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineController.h"
#import "SXXiaoKiController.h"
#import "SXMineChildController.h"
#import "SXMineSettingController.h"
#import "SXPersonalInfoController.h"
#import "SXMineListCell.h"
#import "SXRootTool.h"
#import "SXMineHeaderView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "SXMineNetTool.h"
#import "SXPersonInfoModel.h"

@interface SXMineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXMineHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图

@property (nonatomic, strong) NSMutableArray *dataArray;//数据源
@property (nonatomic, strong) SXMineUserInfoModel *userModel;///个人信息模型
@end

@implementation SXMineController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSArray *array = @[@{@"name":@"我的小K",@"avatar":@"mine_xiaok_mine"},@{@"name":@"我的孩子",@"avatar":@"mine_xiaok_child"},@{@"name":@"测试使用",@"avatar":@"mine_xiaok_child"}];
        _dataArray = [NSMutableArray arrayWithArray:[SXMineUserInfoModel mj_objectArrayWithKeyValuesArray:array]];
    }
    return _dataArray;
}

#pragma mark -life recycle-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    self.navigationController.navigationBar.barTintColor = SXColor2E2E2E;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //用户信息获取
    [self getUserinfoData];
    [self getUserQiniuTokenData];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"设置" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
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
    self.tableView.bounces = NO;
    
    //2.头部视图
    WS(weakSelf);
    SXMineHeaderView *headerView = [SXMineHeaderView headerView];
    headerView.clickMobileBlock = ^{
        DLog(@"clickMobileBlock");
        [weakSelf jumpToPersonVC];
    };
    headerView.clickIconBtnBlock = ^{
        [weakSelf jumpToImagePickerVC];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
}

#pragma mark -点击事件-
- (void)rightButtonAction:(UIButton *)btn{
    SXMineSettingController *settingVC = [[SXMineSettingController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)jumpToPersonVC{
    WS(weakSelf);
    SXPersonalInfoController *personVC = [[SXPersonalInfoController alloc] init];
    personVC.updateAvatarImgBlock = ^{
        [weakSelf getUserinfoData];
    };
    [self.navigationController pushViewController:personVC animated:YES];
}

#pragma mark -获取用户信息-
- (void)getUserinfoData{
    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMineNetTool getUserInfoDataSuccess:^(SXMineUserInfoModel * _Nonnull model) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"model:%@",model);
        weakSelf.userModel = model;
        //头部赋值
        weakSelf.headerView.userModel = model;
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)getUserQiniuTokenData{
    
    [SXMineNetTool getUserQiniuTokenSuccess:^(NSString *token) {
        DLog(@"token:%@",token);
        [SXPersonInfoModel sharedSXPersonInfoModel].qnToken = token;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

- (void)userInfoSetData{
    SXMineUserInfoParam *param = [SXMineUserInfoParam param];
    param.name = self.userModel.name;
    param.avatar = self.userModel.avatar;
    [SXMineNetTool userInfoSetParams:nil Success:^{
        [MBProgressHUD showSuccessWithMessage:@"OK！" toView:SXKeyWindow];
        
    } failure:^(NSError *error) {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXMineUserInfoModel *model = self.dataArray[indexPath.row];
    SXMineListCell *cell = [SXMineListCell cellWithTableView:tableView];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 0) {
//        [SXRootTool changeToHomeVC];
//    } else{
//        [SXRootTool chooseRootWithLoginVC:SXDelegateWindow];
//    }
    
    if (indexPath.row == 0) {
        SXXiaoKiController *xiaokVC = [[SXXiaoKiController alloc] init];
        [self.navigationController pushViewController:xiaokVC animated:YES];
    } else if(indexPath.row == 1){
        SXMineChildController *childVC = [[SXMineChildController alloc] init];
        [self.navigationController pushViewController:childVC animated:YES];
    } else {
        [SXRootTool changeToHomeVC];
    }
}

@end
