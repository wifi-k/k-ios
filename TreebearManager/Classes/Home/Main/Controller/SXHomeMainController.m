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
#import "SXHomeReportController.h"
#import "SXHomeReportDetailController.h"
#import "SXXiaoKiEquipmentOptionController.h"
#import "SXDynamicController.h"
#import "SXHomeMainHeaderView.h"
#import "SXHomeMainSectionHeaderView.h"
#import "SXHomeMainSectionFooterView.h"
#import "SXHomeMainSectionEmptyFooterView.h"
#import "SXHomeMainSectionHeaderView2.h"
#import "SXHomeMainFirstSectionTableCell.h"
#import "SXHomeMainReportCell.h"
#import "SXInputAlertView.h"
#import "SXRootTool.h"
#import "SXNotificationCenterTool.h"
#import "SXXiaoKiOptionResult.h"
#import "SXAddXiaokiNetTool.h"
#import "SXMineNetTool.h"
#import "SXWifiSettingNetTool.h"
#import "SXHomeReportNetTool.h"
#import "SXFamilyMemberNetTool.h"
#import "SXMessageNetTool.h"
#import "NSString+Hash.h"
#import <UMSocialCore/UMSocialCore.h>

@interface SXHomeMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXHomeMainHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图

///手机数据
@property (nonatomic, strong) NSMutableArray *mobileArray;
///周报数据
@property (nonatomic, strong) NSMutableArray *reportArray;
///是否第一次打开页面
@property (nonatomic, assign) BOOL isFirstVisible;
///在线数量
@property (nonatomic, assign) NSInteger total;
@end

@implementation SXHomeMainController

#pragma mark -getter-
- (NSMutableArray *)mobileArray{
    if (_mobileArray == nil) {
        _mobileArray = [NSMutableArray array];
    }
    return _mobileArray;
}

- (NSMutableArray *)reportArray{
    if (_reportArray == nil) {
        _reportArray = [NSMutableArray array];
    }
    return _reportArray;
}

#pragma mark -controller recycle-
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //第一次打开主页默认不执行，从第二次开始刷新
    if (self.isFirstVisible) {
        //选中家庭成员列表
        [self userNodeListallData];
        //用户消息列表
        [self userMessageListData];
    } else {
        self.isFirstVisible = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //添加通知
    [self addNotification];
    //重新登录
    [self loginWithData];
    //获取节点数据
    [self getNodeData];
    //选中家庭成员列表
    [self userNodeListallData];
    //用户消息列表
    [self userMessageListData];
}
    
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"小K云管家";
    
    //1.创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    SXHomeMainHeaderView *headerView = [SXHomeMainHeaderView headerView];
    headerView.clickNameLabelBlock = ^{
        [weakSelf jumpToEquipVC];
    };
    headerView.clickMangerBtnBlock = ^{
        [weakSelf jumpToManagerVC];
    };
    headerView.clickShareBtnBlock = ^{
        [weakSelf shareWebPageToPlatform];
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

    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 330);
}

#pragma mark -添加移除通知-
- (void)addNotification{
    [SXNotificationCenterTool addObserverBindXiaoKiSuccess:self selector:@selector(bindXiaoKiSuccess)];
    [SXNotificationCenterTool addObserverDeviceUpdateRemarkSuccess:self selector:@selector(deviceUpdateRemarkSuccess)];
    [SXNotificationCenterTool addObserverUdpateNickNameSuccess:self selector:@selector(udpateUserInfoSuccess)];
}

- (void)dealloc{
    [SXNotificationCenterTool removeObserverAll:self];
}

- (void)deviceUpdateRemarkSuccess{
    [self userNodeDeviceListData];
    [self userNodeDeviceWeekListData];
}

- (void)bindXiaoKiSuccess{
    SXDynamicController *netVC = [[SXDynamicController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
}

- (void)udpateUserInfoSuccess{
    [self.headerView setUpData];
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
        //获取手机设备列表
        [weakSelf userNodeDeviceListData];
        //获取设备一周上网时长
        [weakSelf userNodeDeviceWeekListData];
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
            [MBProgressHUD showWarningWithMessage:@"此功能开发中..." toView:SXKeyWindow];
//            SXHomeReportController *reportVC = [[SXHomeReportController alloc] init];
//            [self.navigationController pushViewController:reportVC animated:YES];
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

#pragma mark -分享微信-
- (void)shareWebPageToPlatform{
    NSString *inviteCode = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.inviteCode;
    NSString *descStr = [NSString stringWithFormat:@"快来加入我的小K家庭吧，家庭码:%@",inviteCode];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString *thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"邀请家庭成员" descr:descStr thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = RedirectURL;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [MBProgressHUD showWarningWithMessage:@"分享失败!" toView:SXKeyWindow];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
                //[MBProgressHUD showMessageToWindow:@"分享成功!"];
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

#pragma mark -获取节点数据-
- (void)getNodeData{
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        DLog(@"获取节点");
        //更新wan信息
        SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
        [shareInfo setDataWithResult:result];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -登录设备-
- (void)loginWithData{
    //1.尝试登录
    WS(weakSelf);
    SXNetBroadbandParam *param = [SXNetBroadbandParam param];
    param.name = @"admin";
    param.passwd = @"123456".md5String;
    [SXAddXiaokiNetTool loginWithPasswdDataWithParams:param.mj_keyValues Success:^{
        DLog(@"登录成功!");
        [weakSelf getNodeData];
    } failure:^(NSError * _Nonnull error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -家庭节点列表-
- (void)userNodeListallData{
    WS(weakSelf);
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    param.pageNo = @1;
    param.pageSize = @10;
    [SXMineNetTool userNodeListallParams:param.mj_keyValues Success:^(SXHomeXiaoKiResult *result) {
        if (!result.page.count) return;
        BOOL hasSelected = NO;
        for (SXHomeXiaoKiModel *model in result.page) {
            if (model.isSelect.boolValue) {
                SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel = model;
                [weakSelf.headerView setUpData];
                hasSelected = YES;
                break;
            }
        }
        //如果第一分页没有选中，默认选中第一个
        if (!hasSelected) {
            SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel = result.page.firstObject;
            [weakSelf.headerView setUpData];
            [weakSelf userNodeSelectData];//接口选中第一个
        }
        //获取手机设备列表
        [weakSelf userNodeDeviceListData];
        //获取设备一周上网时长
        [weakSelf userNodeDeviceWeekListData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -获取上网设备列表数据接口-
- (void)userNodeDeviceListData{
    WS(weakSelf);
    SXMobilePageParam *param = [SXMobilePageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    param.pageNo = @1;
    param.pageSize = @10;
    param.status = @1;//查询在线状态的设备
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(SXMobileManagerResult * _Nonnull result) {
        weakSelf.total = result.total.integerValue;//在线数量
        weakSelf.mobileArray = [NSMutableArray arrayWithArray:result.page];
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

#pragma mark -获取设备一周上网时长-
- (void)userNodeDeviceWeekListData{
    WS(weakSelf);
    SXHomeReportPageParam *param = [SXHomeReportPageParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    param.pageNo = @1;
    param.pageSize = @10;
    [SXHomeReportNetTool userNodeDeviceWeekListParams:param.mj_keyValues Success:^(SXHomeReportResult *result) {
        //数据初始化
        weakSelf.reportArray = [NSMutableArray arrayWithArray:result.page];
        //刷新UI
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

#pragma mark -用户选定节点-
- (void)userNodeSelectData{
    SXXiaoKiParam *param = [SXXiaoKiParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXFamilyMemberNetTool userNodeSelectDataWithParams:param.mj_keyValues Success:^{
        NSString *equipName = [NSString stringWithFormat:@"已为您切换设备:%@",model.name];
        //[MBProgressHUD showSuccessWithMessage:equipName toView:SXKeyWindow];
        DLog(@"equipName:%@",equipName);
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -查询用户消息列表-
- (void)userMessageListData{
    WS(weakSelf);
    SXHomeMessagePageParam *param = [SXHomeMessagePageParam param];
    param.pageNo = @1;
    param.pageSize = @3;
    [SXMessageNetTool userMessageListParams:param.mj_keyValues Success:^(SXHomeMessageResult *result) {
        //数据初始化
        NSArray *titles = [NSMutableArray arrayWithArray:result.page];
        
        if (titles.count) {
            //获取content数组
            NSArray *contents = [titles valueForKey:@"content"];
            //刷新UI
            [weakSelf.headerView setUpMsgArray:contents];
        }
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        DLog(@"message:%@",message);
    }];
}
    
#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger count = (self.mobileArray.count > 0 ? 1:0);
        return count;
    } else if (section == 1){
        NSInteger count = (self.reportArray.count > 3 ? 3:self.reportArray.count);
        return count;
    }
    return 0;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tempCell = nil;
    if (indexPath.section == 0) {
        SXHomeMainFirstSectionTableCell *cell = [SXHomeMainFirstSectionTableCell cellWithTableView:tableView];
        cell.total = self.total;
        cell.mobileArray = self.mobileArray;
        tempCell = cell;
    } else if(indexPath.section == 1){
        SXHomeMainReportCell *cell = [SXHomeMainReportCell cellWithTableView:tableView];
        SXHomeReportModel *model = self.reportArray[indexPath.row];
        cell.model = model;
        return cell;
    } else {
        return nil;
    }
    return tempCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSInteger count = (self.mobileArray.count > 3 ? 3:self.mobileArray.count);
        return count * 100.0f + 100.0f;
    }
    return 200.0f;
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
        [headerView totalOnLineCount:self.total];
        sectionHeaderV = headerView;
    } else {
        SXHomeMainSectionHeaderView2 *headerView = [SXHomeMainSectionHeaderView2 headerViewWithTableView:tableView];
        sectionHeaderV = headerView;
    }
    return sectionHeaderV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.mobileArray.count) {
            return 0.01f;
        } else {
            return 220.0f;
        }
    } else if (section == 1){
        if (self.reportArray.count) {
            return 80.0f;
        } else {
            return 220.0f;
        }
    } else {
        return 0.01f;
    }
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WS(weakSelf);
    if (section == 0) {
        if (self.mobileArray.count) {
            return [[UIView alloc] initWithFrame:CGRectZero];
        } else {
            SXHomeMainSectionEmptyFooterView *footerView = [SXHomeMainSectionEmptyFooterView footerViewWithImageName:@"img_empty_mobile" title:@"暂无设备" subTitle:@"请绑定设备进行设置"];
            return footerView;
        }
    } else if (section == 1){
        if (self.reportArray.count) {
            SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
            footerView.clickMoreBtnBlock = ^{
                SXHomeReportController *reportVC = [[SXHomeReportController alloc] init];
                [weakSelf.navigationController pushViewController:reportVC animated:YES];
            };
            return footerView;
        } else {
            SXHomeMainSectionEmptyFooterView *footerView = [SXHomeMainSectionEmptyFooterView footerViewWithImageName:@"img_empty_report" title:@"暂无周报" subTitle:@"开启儿童上网关爱查看周报"];
            return footerView;
        }
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
//        SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
//        SXMobileManagerModel *model = self.mobileArray[indexPath.row];
//        detailVC.model = model;
//        [self.navigationController pushViewController:detailVC animated:YES];
    } else if(indexPath.section == 1){
        SXHomeReportDetailController *detailVC = [[SXHomeReportDetailController alloc] init];
        SXHomeReportModel *model = self.reportArray[indexPath.row];
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
//        CGFloat cornerRadius = 8.f;
//        cell.backgroundColor = UIColor.clearColor;
//
//        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//        layer.cornerRadius = 15;
//        layer.shadowColor = UIColor.lightGrayColor.CGColor;
//        layer.shadowOffset = CGSizeMake(2, 0);
//        layer.shadowOpacity = 0.5;
//        layer.shadowRadius = 2;
//        CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init];
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//
//        CGRect bounds = CGRectMake(15, 0, cell.bounds.size.width - 15*2, cell.bounds.size.height);
//
//
//        NSInteger numberOfRows = tableView.numberOfSections;
//        BOOL needSeparator = NO;
//
//        if (indexPath.row == 0 && numberOfRows == 1) {
//            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//        }else if (indexPath.row == 0) {
//            // 初始起点为cell的左下角坐标
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//
//            needSeparator = NO;
//
//        } else if (indexPath.row == numberOfRows -1) {
//            // 初始起点为cell的左上角坐标
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//        } else {
//            CGPathAddRect(pathRef, nil, bounds);
//            needSeparator = NO;
//        }
//
//        layer.path = pathRef;
//        backgroundLayer.path = pathRef;
//        CFRelease(pathRef);
//        layer.fillColor = [UIColor whiteColor].CGColor;
//        if (needSeparator) {
//            CALayer *lineLayer = [[CALayer alloc] init];
//            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//            lineLayer.frame = CGRectMake(tableView.separatorInset.left, bounds.size.height - lineHeight, bounds.size.width - (tableView.separatorInset.left + tableView.separatorInset.right), lineHeight);
//            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
//            [layer addSublayer:lineLayer];
//        }
//
//        UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//        [roundView.layer insertSublayer:layer atIndex:0];
//        roundView.backgroundColor = UIColor.whiteColor;
//        cell.backgroundView = roundView;
//
//        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
//        backgroundLayer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
//        [selectedBackgroundView.layer insertSublayer:backgroundLayer below:cell.layer];
//        selectedBackgroundView.backgroundColor = UIColor.clearColor;
//        cell.selectedBackgroundView = selectedBackgroundView;
    }

}
    
@end
