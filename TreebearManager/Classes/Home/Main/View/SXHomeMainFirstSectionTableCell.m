//
//  SXHomeMainFirstSectionTableCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainFirstSectionTableCell.h"
#import "SXMobileDetailController.h"
#import "SXMobileManagerController.h"
#import "SXHomeNetworkingDeviceCell.h"
#import "SXHomeMainSectionFooterView.h"
#import "SXInputAlertView.h"
#import "SXRootTool.h"
#import "SXWifiSettingNetTool.h"

@interface SXHomeMainFirstSectionTableCell ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SXHomeMainFirstSectionTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifer = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifer owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背样式
    self.contentView.backgroundColor = SXColorWhite;
    
    self.contentBgView.backgroundColor = [UIColor whiteColor];
    self.contentBgView.layer.cornerRadius = 8;
    self.contentBgView.layer.shadowColor = [UIColor colorWithColor:UIColor.lightGrayColor alpha:0.5].CGColor;
    self.contentBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.contentBgView.layer.shadowOpacity = 0.5;
    self.contentBgView.layer.shadowRadius = 5;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = SXColorWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
    
//    [self.contentBgView roundViewWithRadius:8.0f borderColor:UIColor.lightGrayColor borderWidth:1.0f];
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
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = (self.mobileArray.count > 3 ? 3:self.mobileArray.count);
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXHomeNetworkingDeviceCell *cell = [SXHomeNetworkingDeviceCell cellWithTableView:tableView];
    SXMobileManagerModel *model = self.mobileArray[indexPath.row];
    cell.model = model;
    cell.clickRemarkBtnBlock = ^(SXMobileManagerModel * _Nonnull model) {
        [weakSelf alertRemarkNameView:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.mobileArray.count) {
        return 80.0f;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.mobileArray.count) {
        SXHomeMainSectionFooterView *footerView = [SXHomeMainSectionFooterView footerView];
        footerView.clickMoreBtnBlock = ^{
            SXMobileManagerController *mobileManagerVC = [[SXMobileManagerController alloc] init];
            [SXRootTool pushToVC:mobileManagerVC];
        };
        return footerView;
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLog(@"%ld-%ld:",indexPath.section,indexPath.row);
    
    SXMobileDetailController *detailVC = [[SXMobileDetailController alloc] init];
    SXMobileManagerModel *model = self.mobileArray[indexPath.row];
    detailVC.model = model;
    [SXRootTool pushToVC:detailVC];
}

@end
