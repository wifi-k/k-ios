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
#import "SXHomeMainSectionEmptyFooterView.h"
#import "SXHomeMainSectionHeaderView2.h"
#import "SXHomeMainSectionFooterView2.h"
#import "SXHomeNetworkingDeviceCell.h"
#import "SXInputAlertView.h"
#import "SXRootTool.h"
#import "SXNotificationCenterTool.h"
#import "SXXiaoKiOptionResult.h"
#import "SXAddXiaokiNetTool.h"
#import "SXMineNetTool.h"
#import "SXWifiSettingNetTool.h"
#import <UMSocialCore/UMSocialCore.h>

@interface SXHomeMainController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) SXHomeMainHeaderView *headerView;//头部视图
@property (nonatomic, weak) UITableView *tableView;//列表视图

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXHomeMainController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //添加通知
    [self addNotification];
    //获取节点数据
    [self getNodeData];
    //选中家庭成员
    [self userNodeListallData];
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

    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 360);
}

#pragma mark -添加移除通知-
- (void)addNotification{
    [SXNotificationCenterTool addObserverBindXiaoKiSuccess:self selector:@selector(bindXiaoKiSuccess)];
    [SXNotificationCenterTool addObserverDeviceUpdateRemarkSuccess:self selector:@selector(deviceUpdateRemarkSuccess)];
}

- (void)dealloc{
    [SXNotificationCenterTool removeObserverAll:self];
}

- (void)bindXiaoKiSuccess{
    //跳转下一个页面
    SXNetOptionController *netVC = [[SXNetOptionController alloc] init];
    [self.navigationController pushViewController:netVC animated:YES];
}

- (void)deviceUpdateRemarkSuccess{
    [self userNodeDeviceListData];
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
- (void)alertRemarkNameView:(SXMobileManagerModel *)model{
    WS(weakSelf);
    SXInputAlertView *nameAlertView = [SXInputAlertView alertWithTitle:@"备注名称" placeholder:@"请输入名称" confirmStr:@"确定" cancelStr:@"取消"];
    nameAlertView.confirmButtonBlock = ^(NSString * _Nonnull text) {
        DLog(@"text:%@",text);
        [weakSelf userDodeDeviceSetData:model note:text];
    };
    [nameAlertView alert];
}

#pragma mark -分享微信-
- (void)shareWebPageToPlatform{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString *thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享家庭码" descr:@"请点击查看!!!!!!!" thumImage:thumbURL];
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
                
                [MBProgressHUD showMessageToWindow:@"分享成功!"];
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
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
        }
        
        //获取手机设备列表
        [weakSelf userNodeDeviceListData];
    } failure:^(NSError *error) {
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(SXMobileManagerResult * _Nonnull result) {
        weakSelf.dataArray = [NSMutableArray arrayWithArray:result.page];
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}

#pragma mark -修改设备信息数据接口-
- (void)userDodeDeviceSetData:(SXMobileManagerModel *)model note:(NSString *)note{
    WS(weakSelf);
    SXMobilePageParam *param = [SXMobilePageParam param];
    param.nodeId = model.nodeId;
    param.mac = model.mac;
    param.isBlock = model.isBlock;
    param.note = note;
    [SXWifiSettingNetTool userDodeDeviceSetDataWithParams:param.mj_keyValues success:^{
        [MBProgressHUD showSuccessWithMessage:@"修改成功!" toView:SXKeyWindow];
        model.note = note;//如果修改成功，直接模型赋值
        model.name = note;
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        });
    }];
}
    
#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSInteger count = (self.dataArray.count > 3 ? 3:self.dataArray.count);
        return count;
    }
    return 0;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tempCell = nil;
    if (indexPath.section == 0) {
        WS(weakSelf);
        SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
        SXMobileManagerModel *model = self.dataArray[indexPath.row];
        cell.model = model;
        cell.clickRemarkBtnBlock = ^(SXMobileManagerModel * _Nonnull model) {
            [weakSelf alertRemarkNameView:model];
        };
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
        [headerView setUpData:self.dataArray];
        sectionHeaderV = headerView;
    } else {
        SXHomeMainSectionHeaderView2 *headerView = [SXHomeMainSectionHeaderView2 headerViewWithTableView:tableView];
        sectionHeaderV = headerView;
    }
    return sectionHeaderV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dataArray.count) {
            return 80.0f;
        } else {
            return 200.0f;
        }
    } else if (section == 1){
        return 230.0f;
    } else {
        return 0.01;
    }
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WS(weakSelf);
    if (section == 0) {
        if (self.dataArray.count) {
            SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
            footerView.clickMoreBtnBlock = ^{
                SXMobileManagerController *mobileManagerVC = [[SXMobileManagerController alloc] init];
                [weakSelf.navigationController pushViewController:mobileManagerVC animated:YES];
            };
            return footerView;
        } else {
            SXHomeMainSectionEmptyFooterView *footerView = [SXHomeMainSectionEmptyFooterView footerView];
            return footerView;
        }
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
        SXMobileManagerModel *model = self.dataArray[indexPath.row];
        detailVC.model = model;
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
