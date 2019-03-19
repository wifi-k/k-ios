//
//  SXDropDownMenu.m
//  TreebearManager
//
//  Created by bear on 2019/3/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXDropDownMenu.h"

#define CELL_HEIGHT 40

@interface SXDropDownMenu ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic) CGRect btnFrame;

@property(nonatomic, strong) NSArray *titles;
@end

@implementation SXDropDownMenu

+ (instancetype)dropMenu{
    return [[self alloc] initWithFrame:SXKeyWindow.bounds];
}

- (void)showDropDownMenuWithButtonFrame:(CGRect)buttonFrame titles:(NSArray *)titles{
    
    self.backgroundColor = [UIColor whiteColor];
    self.tableView = (UITableView *)[super init];
    
    self.btnFrame = buttonFrame;
    if (self) {
        CGRect btnRect = buttonFrame;//按钮在视图上的位置
        CGFloat height = 0;//菜单高度
        if ( titles.count <= 4) {
            height = titles.count * CELL_HEIGHT;
        }else{
            height = 200;
        }
        
        self.titles = [NSArray arrayWithArray:titles];
        
        //菜单视图的起始大小和位置
        self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, 0);
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.3;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 5;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorColor = [UIColor grayColor];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0.001)];//最后无分割线
        [self.tableView flashScrollIndicators];//显示滚动条
        
        [UIView animateWithDuration:0.25 animations:^{
            //菜单视图的最终大小和位置
            self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, height);
            self.tableView.frame = CGRectMake(0, 0, btnRect.size.width, height);
        } completion:^(BOOL finished) {
            [self addSubview:self.tableView];
        }];
    }
}

- (void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height+2, btnFrame.size.width, 0);
        self.tableView.frame = CGRectMake(0, 0, btnFrame.size.width, 0);    
    }];
}

#pragma mark -datasource/delegagte-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *XDSDropDownMenuID = @"XDSDropDownMenuID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XDSDropDownMenuID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XDSDropDownMenuID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self hideDropDownMenuWithBtnFrame:self.btnFrame];
    
    if ([_delegate respondsToSelector:@selector(popDropMenu: row:)]) {
        [_delegate popDropMenu:self row:indexPath.row];
    }
}

@end
