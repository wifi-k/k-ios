//
//  XDSDropDownMenu.m
//  shts_ios_xds
//
//  Created by cdj on 2018/5/8.
//  Copyright © 2018年 itiis. All rights reserved.
//

#import "XDSDropDownMenu.h"

@interface XDSDropDownMenu()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *menuTableView;
@property(nonatomic) CGRect buttonFrame;
@property(nonatomic, strong) NSArray *titleList;
@end

@implementation XDSDropDownMenu

- (void)showDropDownMenuWithButtonFrame:(CGRect)buttonFrame arrayOfTitle:(NSArray *)titleArr{
    
    self.backgroundColor = [UIColor whiteColor];
    self.menuTableView = (UITableView *)[super init];
    
    self.buttonFrame = buttonFrame;
    if (self) {
        CGRect btnRect = buttonFrame;//按钮在视图上的位置
        CGFloat height = 0;//菜单高度
        if ( titleArr.count <= 4) {
            height = titleArr.count *40;
        }else{
            height = 200;
        }
        
        self.titleList = [NSArray arrayWithArray:titleArr];
        
        //菜单视图的起始大小和位置
        self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, 0);
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.3;
        
        self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0)];
        self.menuTableView.delegate = self;
        self.menuTableView.dataSource = self;
        self.menuTableView.layer.cornerRadius = 5;
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.menuTableView.separatorColor = [UIColor grayColor];
        self.menuTableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
        self.menuTableView.backgroundColor = [UIColor whiteColor];
        self.menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnRect.size.width, 0.001)];//最后无分割线
        [self.menuTableView flashScrollIndicators];//显示滚动条
        
        [UIView beginAnimations:nil context:nil];//动画
        [UIView setAnimationDuration:0.25];
        //菜单视图的最终大小和位置
        self.frame = CGRectMake(btnRect.origin.x, btnRect.origin.y+btnRect.size.height+2, btnRect.size.width, height);
        self.menuTableView.frame = CGRectMake(0, 0, btnRect.size.width, height);
        [UIView commitAnimations];
        [self addSubview:self.menuTableView];
    }
}

- (void)hideDropDownMenuWithBtnFrame:(CGRect)btnFrame {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.frame = CGRectMake(btnFrame.origin.x, btnFrame.origin.y+btnFrame.size.height+2, btnFrame.size.width, 0);
    self.menuTableView.frame = CGRectMake(0, 0, btnFrame.size.width, 0);
    [UIView commitAnimations];
}

#pragma mark -datasource/delegagte-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"XDSDropDownMenuID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.titleList objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideDropDownMenuWithBtnFrame:self.buttonFrame];
    
    [_delegate setDropDownDelegate:self];
}

@end
