//
//  SXWifiSettingSectionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXWifiSettingSectionHeaderView.h"

@interface SXWifiSettingSectionHeaderView ()
@property (nonatomic, weak) UILabel *titleL;
@end

@implementation SXWifiSettingSectionHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    SXWifiSettingSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SXWifiSettingSectionHeaderViewID];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:SXWifiSettingSectionHeaderViewID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        //1.设置白色背景
        self.contentView.backgroundColor = SXColorBgViewGray;
        
        //2.初始化UI
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    //1.标题
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = SXFont15;
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.textColor = SXColor2B3852;
    [self.contentView addSubview:titleL];
    self.titleL = titleL;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark -setter方法-
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}

@end
