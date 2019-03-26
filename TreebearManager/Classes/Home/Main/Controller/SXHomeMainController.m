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
#import "SXWifiSettingController.h"
#import "SXFamilyMemberController.h"
#import "SXMobileManagerController.h"
#import "SXMobileDetailController.h"
#import "SXHomeReportController.h"
#import "SXXiaoKiEquipmentOptionController.h"
#import "SXNetOptionController.h"
#import "SXHomeMainHeaderView.h"
#import "SXHomeMainSectionHeaderView.h"
#import "SXHomeMainSectionFooterView.h"
#import "SXHomeMainSectionHeaderView2.h"
#import "SXHomeMainSectionFooterView2.h"
#import "SXHomeNetworkingDeviceCell.h"
#import "SXInputAlertView.h"
#import "SXRootTool.h"
#import "SXNotificationCenterTool.h"
#import "SXXiaoKiOptionResult.h"

@interface SXHomeMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXHomeMainHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图
@end

@implementation SXHomeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //添加通知
    [self addNotification];
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
    headerView.clickNameLabelBlock = ^{
        [weakSelf jumpToEquipVC];
    };
    headerView.clickMangerBtnBlock = ^{
        [weakSelf jumpToManagerVC];
    };
    headerView.clickShareBtnBlock = ^{
        [MBProgressHUD showMessage:@"微信分享!" toView:weakSelf.view];
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
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    self.tableView.frame = self.view.bounds;

    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 360);
}

#pragma mark -添加移除通知-
- (void)addNotification{
    [SXNotificationCenterTool addObserverBindXiaoKiSuccess:self selector:@selector(bindXiaoKiSuccess)];
}

- (void)dealloc{
    [SXNotificationCenterTool removeObserverAll:self];
}

- (void)bindXiaoKiSuccess{
    //跳转下一个页面
    SXNetOptionController *netVC = [[SXNetOptionController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
}

#pragma mark -页面跳转-
- (void)jumpToManagerVC{
    SXFamilyMemberController *managerVC = [[SXFamilyMemberController alloc] init];
    [self.navigationController pushViewController:managerVC animated:YES];
}

- (void)jumpToEquipVC{
    WS(weakSelf);
    SXXiaoKiEquipmentOptionController *equipVC = [[SXXiaoKiEquipmentOptionController alloc] init];
    equipVC.selectOptionModelBlock = ^{
        //刷新数据显示
        [weakSelf.headerView setUpData];
    };
    [self.navigationController pushViewController:equipVC animated:YES];
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
            SXParentControlController *parentVC = [[SXParentControlController alloc] init];
            [self.navigationController pushViewController:parentVC animated:YES];
        }
            break;
        case 1:{
            SXHealtyControlController *healthVC = [[SXHealtyControlController alloc] init];
            [self.navigationController pushViewController:healthVC animated:YES];
        }
            break;
        case 2:{
            SXHomeReportController *reportVC = [[SXHomeReportController alloc] init];
            [self.navigationController pushViewController:reportVC animated:YES];
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

#pragma mark -弹窗视图-
- (void)alertRemarkNameView{
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
    };
    [nameAlertView alert];
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
        WS(weakSelf);
        SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
        cell.clickRemarkBtnBlock = ^{
            [weakSelf alertRemarkNameView];
        };
        tempCell = cell;
    } else if(indexPath.section == 1){
        SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
        tempCell = cell;
    } else {
        return nil;
    }
    return tempCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 80.0;
    } else if(section == 1){
        return 50.0f;
    } else {
        return 0.01f;
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
    if (section == 0) {
        return 80.0f;
    } else if (section == 1){
        return 230.0f;
    } else {
        return 0.01;
    }
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WS(weakSelf);
    if (section == 0) {
        SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
        footerView.clickMoreBtnBlock = ^{
            SXMobileManagerController *mobileManagerVC = [[SXMobileManagerController alloc] init];
            [weakSelf.navigationController pushViewController:mobileManagerVC animated:YES];
        };
        return footerView;
    } else if (section == 1){
        SXHomeMainSectionFooterView2 *footerView = [SXHomeMainSectionFooterView2 footerView];
        footerView.clickReportBtnBlock = ^{
            SXHomeReportController *reportVC = [[SXHomeReportController alloc] init];
            [weakSelf.navigationController pushViewController:reportVC animated:YES];
        };
        return footerView;
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
