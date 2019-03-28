//
//  SXPreventController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPreventController.h"
#import "SXNetPreventCell.h"
#import "SXWifiSettingNetTool.h"
#import "SXXiaoKInfoModel.h"

@interface SXPreventController ()
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXPreventController

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
    
    [self setUpData];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"防蹭网";
}

- (void)setUpData{
    WS(weakSelf);
    SXPreventPageParam *param = [SXPreventPageParam param];
    param.nodeId = SXXiaoKInfoModel.sharedSXXiaoKInfoModel.modelId;
    param.pageNo = @1;
    param.pageSize = @10;
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    [SXWifiSettingNetTool userNodeDeviceListDataWithParams:param.mj_keyValues success:^(NSArray * _Nonnull array) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        
        //数据初始化
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        //刷新UI
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
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
    SXNetPreventCell *cell = [SXNetPreventCell cellWithTableView:tableView];
    SXPreventModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
