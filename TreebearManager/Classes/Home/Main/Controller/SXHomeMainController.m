//
//  SXHomeConnectedController.m
//  TreebearManager
//
//  Created by bear on 2019/1/31.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainController.h"
#import "SXXiaoKiController.h"
#import "SXMessageController.h"
#import "SXParentControlController.h"
#import "SXHealtyControlController.h"
#import "SXCheckReportController.h"
#import "SXWifiSettingController.h"
#import "SXFamilyMemberController.h"
#import "SXHomeMainHeaderView.h"
#import "SXHomeMainSectionHeaderView.h"
#import "SXHomeMainSectionFooterView.h"
#import "SXHomeMainSectionHeaderView2.h"
#import "SXHomeMainSectionFooterView2.h"
#import "SXHomeNetworkingDeviceCell.h"
#import "SXRootTool.h"
#import "SXAlbumAuthorizationTool.h"
#import "SXAlertControllerTool.h"
#import <Photos/Photos.h>

@interface SXHomeMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXHomeMainHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图
@end

@implementation SXHomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}
    
- (void)setUpUI{
    
    self.view.backgroundColor = UIColor.redColor;
    
    self.navigationItem.title = @"小K管家";
    
    //1.创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    SXHomeMainHeaderView *headerView = [SXHomeMainHeaderView headerView];
    headerView.clickMangerBtnBlock = ^{
        [weakSelf jumpToManagerVC];
    };
    headerView.clickUserInfoBtnBlock = ^{
        [weakSelf jumpToXiaoKiVC];
    };
    headerView.clickMessageBgViewBlock = ^{
        [weakSelf jumpToMessgeVC];
    };
    headerView.clickSettingBtnBlock = ^(NSInteger tag) {
        [weakSelf jumpToWifiSettingVC:tag];
    };
    headerView.clickBackupBtnBlock = ^{
        [weakSelf checkAlbumAuthorization];
    };
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    //3.注册头部视图
    [self.tableView registerClass:SXHomeMainSectionHeaderView.class forHeaderFooterViewReuseIdentifier:SXHomeMainSectionHeaderViewID];
    [self.tableView registerClass:SXHomeMainSectionHeaderView2.class forHeaderFooterViewReuseIdentifier:SXHomeMainSectionHeaderView2ID];
}

#pragma mark -相册授权-
- (void)checkAlbumAuthorization{
    WS(weakSelf);
    [SXAlbumAuthorizationTool checkAlbumAuthorization:^(NSInteger status) {
        if (status != 3) {//没有授权，去请求授权
            [SXAlbumAuthorizationTool requestAlbumAuthorizationSuccess:^{
                DLog(@"请求成功");
                //直接读取
                DLog(@"读取数据");
            } failure:^{
                DLog(@"请求失败");
                [weakSelf alertSettingView];
            }];
        } else{
            //直接读取
            DLog(@"读取数据");
        }
    }];
}

#pragma mark -系统弹窗提示-
- (void)alertSettingView{
    [SXAlertControllerTool alertWithTitle:@"提示" message:@"您的相册访问权限未开启，请到手机隐私设置" confirm:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } cancel:^(UIAlertAction * _Nonnull action) {
        DLog(@"action.title:%@",action.title);
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    self.tableView.frame = self.view.bounds;

    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 420);
}

#pragma mark -页面跳转-
- (void)jumpToManagerVC{
    SXFamilyMemberController *managerVC = [[SXFamilyMemberController alloc] init];
    [self.navigationController pushViewController:managerVC animated:YES];
}

- (void)jumpToXiaoKiVC{
    SXXiaoKiController *messageVC = [[SXXiaoKiController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)jumpToMessgeVC{
    SXMessageController *messageVC = [[SXMessageController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)jumpToWifiSettingVC:(NSInteger)tag{
    switch (tag) {
        case 0:{
            SXParentControlController *switchVC = [[SXParentControlController alloc] init];
            [self.navigationController pushViewController:switchVC animated:YES];
        }
            break;
        case 1:{
            SXHealtyControlController *switchVC = [[SXHealtyControlController alloc] init];
            [self.navigationController pushViewController:switchVC animated:YES];
        }
            break;
        case 2:{
            SXCheckReportController *switchVC = [[SXCheckReportController alloc] init];
            [self.navigationController pushViewController:switchVC animated:YES];
        }
            break;
        case 3:{
            SXWifiSettingController *wifiSettingVC = [[SXWifiSettingController alloc] init];
            [self.navigationController pushViewController:wifiSettingVC animated:YES];
        }
            break;
        default:
            break;
    }
}
    
#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 0;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tempCell = nil;
    if (indexPath.section == 0) {
        SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
        tempCell = cell;
    } else{
        SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
        tempCell = cell;
    }
    return tempCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 80.0;
    } else{
        return 50.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderV = nil;
    if (section == 0) {
        SXHomeMainSectionHeaderView *headerView = [SXHomeMainSectionHeaderView headerViewWithTableView:tableView];
        sectionHeaderV = headerView;
    } else {
        SXHomeMainSectionHeaderView2 *headerView = [SXHomeMainSectionHeaderView2 headerViewWithTableView:tableView];
        sectionHeaderV = headerView;
    }
    return sectionHeaderV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 230.0f;
    } else if (section == 0){
        return 80.0f;
    }
    return 0.01;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        SXHomeMainSectionFooterView2 *footerView = [SXHomeMainSectionFooterView2 footerView];
        return footerView;
    } else {
        SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
        footerView.clickMoreBtnBlock = ^{
            DLog(@"点击更多");
            [SXRootTool changeToHomeVC];
        };
        return footerView;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
    if (indexPath.section == 0) {//第一分组
        //圆率
        CGFloat cornerRadius = 10.0;
        //大小
        CGRect bounds = cell.bounds;
        bounds.origin.x += 15;
        bounds.size.width -= 30;
        //行数
        NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
        //绘制曲线
        UIBezierPath *bezierPath = nil;
        
        if (indexPath.row == 0 && numberOfRows == 1) {
            //一个为一组时,四个角都为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == 0) {
            //为组的第一行时,左上、右上角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == numberOfRows - 1) {
            //为组的最后一行,左下、右下角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else {
            //中间的都为矩形
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
        //cell的背景色透明
        cell.backgroundColor = [UIColor clearColor];
        //新建一个图层
        CAShapeLayer *layer = [CAShapeLayer layer];
        //图层边框路径
        layer.path = bezierPath.CGPath;
        //图层填充色,也就是cell的底色
        layer.fillColor = SXColorWhite.CGColor;
        //图层边框线条颜色
        //layer.strokeColor = SXColorRandom.CGColor;
        //将图层添加到cell的图层中,并插到最底层
        [cell.contentView.layer insertSublayer:layer atIndex:0];
    }*/
}
    
@end
