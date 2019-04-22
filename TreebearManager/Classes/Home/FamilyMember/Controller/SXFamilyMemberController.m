//
//  SXFamilyMemberController.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberController.h"
#import "SXFamilyMemberFooterView.h"
#import "SXFamilyMemberCell.h"
#import "SXTitleAlertView.h"
#import "SXFamilyMemberNetTool.h"
#import "SXXiaoKiOptionResult.h"
#import <UMSocialCore/UMSocialCore.h>

@interface SXFamilyMemberController ()
///底部视图
@property (nonatomic, weak) UIView *footerBgView;

///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXFamilyMemberController

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
    
    //家庭成员列表数据
    [self userNodeFamilyListData];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"家庭成员";
    
    //4.添加底部视图
//    UIView *footerBgView = [[UIView alloc] init];
//    footerBgView.backgroundColor = SXColorWhite;
//    footerBgView.height = 120;
//    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
//    WS(weakSelf);
//    SXFamilyMemberFooterView *footerView = [SXFamilyMemberFooterView
//                                            footerView];
//    footerView.clickAddMemberBlock = ^{
//        [weakSelf alertUpdateNameView];
//    };
//    [self.tableView.tableFooterView addSubview:footerView];
//    footerView.frame = self.tableView.tableFooterView.bounds;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    [self.view addSubview:footerBgView];
    self.footerBgView = footerBgView;
    
    WS(weakSelf);
    SXFamilyMemberFooterView *footerView = [SXFamilyMemberFooterView footerView];
    footerView.frame = footerBgView.bounds;
    footerView.clickAddMemberBlock = ^{
        [weakSelf alertUpdateNameView];
    };
    [footerBgView addSubview:footerView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.footerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(100);
    }];
}

#pragma mark -视图弹窗-
- (void)alertUpdateNameView{
    [self shareWebPageToPlatform];
}

#pragma mark -视图弹窗-
- (void)alertDeleteAlertView:(SXFamilyMemberModel *)model{
    WS(weakSelf);
    SXTitleAlertView *deleteAlertView = [SXTitleAlertView alertWithTitle:@"提示" content:@"您确定要删除此成员吗?" confirmStr:@"确定" cancelStr:@"取消"];
    deleteAlertView.confirmButtonBlock = ^{
        [weakSelf userNodeFamilyQuitData:model];
    };
    [deleteAlertView alert];
}

#pragma mark -分享微信-
- (void)shareWebPageToPlatform{
    NSString *inviteCode = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel.inviteCode;
    NSString *descStr = [NSString stringWithFormat:@"快来加入我的小K家庭吧，家庭码:%@",inviteCode];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString *thumbURL = [NSString stringWithFormat:@"%@/h5/inviteCode.html?inviteCode=%@",API_HOST_H5,inviteCode];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"邀请家庭成员" descr:descStr thumImage:@"img_xiaok_icon"];
    //设置网页地址
    shareObject.webpageUrl = thumbURL;
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
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

#pragma mark -家庭成员列表接口-
- (void)userNodeFamilyListData{
    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    SXHomeXiaoKiModel *model = SXXiaoKiOptionResult.sharedSXXiaoKiOptionResult.selectedModel;
    param.nodeId = model.nodeId;
    [SXFamilyMemberNetTool userNodeFamilyListDataWithParams:param.mj_keyValues Success:^(NSArray *array) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        DLog(@"array:%@",array);
        //刷新表格显示
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

- (void)userNodeFamilyQuitData:(SXFamilyMemberModel *)model{
    WS(weakSelf);
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    SXFamilyMemberParam *param = [SXFamilyMemberParam param];
    param.nodeId = model.nodeId;
    param.userId = model.userId;
    [SXFamilyMemberNetTool userNodeFamilyQuitDataWithParams:param.mj_keyValues Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        [MBProgressHUD showSuccessWithMessage:@"删除成功!" toView:SXKeyWindow];
        [weakSelf.dataArray removeObject:model];
        [weakSelf.tableView reloadData];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXFamilyMemberCell *cell = [SXFamilyMemberCell cellWithTableView:tableView];
    SXFamilyMemberModel *model = self.dataArray[indexPath.row];
    model.isShow = self.isShow;
    cell.model = model;
    cell.clickDeleteBtnBlock = ^(SXFamilyMemberModel *model) {
        [weakSelf alertDeleteAlertView:model];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
