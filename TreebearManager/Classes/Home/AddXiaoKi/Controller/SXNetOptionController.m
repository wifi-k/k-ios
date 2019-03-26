//
//  SXNetOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetOptionController.h"
#import "SXNetBroadbandController.h"
#import "SXNetStaticController.h"
#import "SXDynamicController.h"
#import "SXNetOptionCell.h"
#import "SXNetOptionFooterView.h"
#import "SXAddXiaokiNetTool.h"

@interface SXNetOptionController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
///底部视图
@property (nonatomic, weak) SXNetOptionFooterView *footerView;
@end

@implementation SXNetOptionController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        SXNetOptionModel *model0 = [[SXNetOptionModel alloc] init];
        model0.title = @"宽带拨号上网";
        model0.selected = @(YES);
        model0.row= @(0);
        [_dataArray addObject:model0];
        
        SXNetOptionModel *model1 = [[SXNetOptionModel alloc] init];
        model1.title = @"静态IP上网";
        model1.selected = @(NO);
        model1.row= @(1);
        [_dataArray addObject:model1];
        
        SXNetOptionModel *model2 = [[SXNetOptionModel alloc] init];
        model2.title = @"动态IP上网";
        model2.selected = @(NO);
        model2.row= @(2);
        [_dataArray addObject:model2];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"选择上网方式";
    
    //4.添加底部视图
    UIView *footerBgView = [[UIView alloc] init];
    footerBgView.backgroundColor = SXColorWhite;
    footerBgView.height = 120;
    self.tableView.tableFooterView = footerBgView;
    
    //2.添加底部视图
    WS(weakSelf);
    SXNetOptionFooterView *footerView = [SXNetOptionFooterView footerView];
    footerView.dataArray = self.dataArray;
    footerView.clickNextBtnBlock = ^(SXNetOptionModel * _Nonnull model) {
        DLog(@"%@-%@",model.title,model.selected);
        [weakSelf jumpToNetVC:model];
    };
    [self.tableView.tableFooterView addSubview:footerView];
    footerView.frame = self.tableView.tableFooterView.bounds;
    self.footerView = footerView;
}

#pragma mark -跳转网络连接页面-
- (void)jumpToNetVC:(SXNetOptionModel *)model{
    switch (model.row.integerValue) {
        case 0:{
            SXNetBroadbandController *broadVC = [[SXNetBroadbandController alloc] init];
            [self.navigationController pushViewController:broadVC animated:YES];
        }
            break;
        case 1:{
            SXNetStaticController *broadVC = [[SXNetStaticController alloc] init];
            [self.navigationController pushViewController:broadVC animated:YES];
        }
            break;
        case 2:{
            [self networkStatusData];
        }
            break;
        default:
            break;
    }
}

#pragma mark -查询网络状态-
- (void)networkStatusData{
    [self.footerView setBtnEnabled:NO];
    WS(weakSelf);
    static NSInteger count = 0;
    [SXAddXiaokiNetTool networkStatusWithDataSuccess:^{
        [weakSelf.footerView setBtnEnabled:YES];
        DLog(@"网络状态正常");
        SXDynamicController *broadVC = [[SXDynamicController alloc] init];
        [weakSelf.navigationController pushViewController:broadVC animated:YES];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf.footerView setBtnEnabled:NO];
        ++count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //递归方法
            if (error.code == 1 && count%3 != 0) {
                [weakSelf networkStatusData];
            } else{
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"请检查配置参数，然后重试!" toView:weakSelf.view];
                });
            }
        });
    }];
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXNetOptionCell *cell = [SXNetOptionCell cellWithTableView:tableView];
    SXNetOptionModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (SXNetOptionModel *model in self.dataArray) {
        model.selected = @(NO);
    }
    
    SXNetOptionModel *model = self.dataArray[indexPath.row];
    model.selected = @(YES);
    
    //刷新数组
    [self.tableView reloadData];
    
    //按钮可点击
    [self.footerView setBtnEnabled:YES];
}

@end
