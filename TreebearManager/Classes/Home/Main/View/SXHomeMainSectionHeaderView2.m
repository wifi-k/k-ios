//
//  SXHomeMainSectionHeaderView2.m
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionHeaderView2.h"

@interface SXHomeMainSectionHeaderView2 ()

@property (weak, nonatomic) UILabel *titleL;

@end

@implementation SXHomeMainSectionHeaderView2

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    SXHomeMainSectionHeaderView2 *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SXHomeMainSectionHeaderView2ID];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:SXHomeMainSectionHeaderView2ID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        //1.设置白色背景
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //3.初始化UI
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = SXFontBold23;
    titleL.textColor = SXColor333333;
    [self.contentView addSubview:titleL];
    self.titleL = titleL;
    
    self.titleL.text = @"儿童上网关爱";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}

@end
