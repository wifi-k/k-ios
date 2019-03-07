//
//  SXChannelOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXChannelOptionController.h"
#import "SXAdvancedOptionCell.h"

@interface SXChannelOptionController ()
///模型数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXChannelOptionController

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            SXAdvancedOptionModel *model = [[SXAdvancedOptionModel alloc] init];
            model.title = [NSString stringWithFormat:@"1%dbn",i];
            if(i == 0){
                model.selected = @(YES);
            } else {
                model.selected = @(NO);
            }
            model.row= @(i);
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"无线信道";
}

#pragma mark -UITableViewDelegate/UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXAdvancedOptionCell *cell = [SXAdvancedOptionCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (SXAdvancedOptionModel *model in self.dataArray) {
        model.selected = @(NO);
    }
    
    SXAdvancedOptionModel *model = self.dataArray[indexPath.row];
    model.selected = @(YES);
    
    //刷新数组
    [self.tableView reloadData];
}

@end
