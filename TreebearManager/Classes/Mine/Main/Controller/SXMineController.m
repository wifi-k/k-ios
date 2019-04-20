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
#import "SXCodeInputAlertView.h"
#import "SXMineNetTool.h"
#import "SXNotificationCenterTool.h"
#import "SXFamilyMemberNetTool.h"

@interface SXMineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXMineHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图

@property (nonatomic, strong) NSMutableArray *dataArray;//数据源
@end

@implementation SXMineController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        NSArray *array = @[@{@"name":@"我的小K",@"avatar":@"mine_xiaok_mine"},@{@"name":@"加入新家庭",@"avatar":@"mine_xiaok_add"}];
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
    
    //获取七牛云token
    [self getUserQiniuTokenData];
    
    //用户信息获取
    [self userInfoGetextData];
    
    //添加通知
    [self addNotification];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
//    self.navigationItem.title = @"我的";
    
    //设置icon
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"img_setting_mine"] highImage:[UIImage imageNamed:@"img_setting_mine"] target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    //1.创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = SXColorWhite;
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
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
}

#pragma mark -添加移除通知-
- (void)addNotification{
    [SXNotificationCenterTool addObserverUdpateNickNameSuccess:self selector:@selector(udpateUserInfoSuccess)];
    [SXNotificationCenterTool addObserverUpdateMobileSuccess:self selector:@selector(udpateUserInfoSuccess)];
}

- (void)dealloc{
    [SXNotificationCenterTool removeObserverAll:self];
}

- (void)udpateUserInfoSuccess{
    [self.headerView setUpData];
    
    //通过接口更新用户信息
    [self userInfoGetextData];
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
        //1.更新数据
        [weakSelf.headerView setUpData];
    };
    [self.navigationController pushViewController:personVC animated:YES];
}

#pragma mark -获取用户信息(最新)-
- (void)userInfoGetextData{
    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXMineNetTool userInfoGetextDataWithFilter:@1 Success:^(SXMineUserInfoResult *result) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"result:%@",result);
        //1.单利赋值
        SXPersonInfoModel.sharedSXPersonInfoModel.result = result;
        //2.头部赋值
        [weakSelf.headerView setUpData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -从服务端获取七牛云token-
- (void)getUserQiniuTokenData{
    [SXMineNetTool getUserQiniuTokenSuccess:^(NSString *token) {
        DLog(@"token:%@",token);
        SXPersonInfoModel.sharedSXPersonInfoModel.qnToken = token;
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    WS(weakSelf);
    SXCodeInputAlertView *nameAlertView = [SXCodeInputAlertView alertWithTitle:@"输入家庭码加入家庭" placeholder:@"请输家庭码" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf userNodeFamilyJoin:text];
    };
    [nameAlertView alert];
}

- (void)userNodeFamilyJoin:(NSString *)text{
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    param.inviteCode = text;
    [SXFamilyMemberNetTool userNodeFamilyJoinDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccessWithMessage:@"添加成功!" toView:SXKeyWindow];
        });
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
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
    
    if (indexPath.row == 0) {
        SXXiaoKiController *xiaokVC = [[SXXiaoKiController alloc] init];
        [self.navigationController pushViewController:xiaokVC animated:YES];
    } else if(indexPath.row == 1){
        [self alertUpdateNameView];
    } else if(indexPath.row == 2){
//        [SXRootTool changeToHomeVC];
//        DLog(@"Ohters");
    } else {
//        SXMineChildController *childVC = [[SXMineChildController alloc] init];
//        [self.navigationController pushViewController:childVC animated:YES];
    }
}

@end
