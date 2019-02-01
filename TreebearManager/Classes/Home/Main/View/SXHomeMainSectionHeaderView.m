//
//  SXHomeMainSectionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionHeaderView.h"

@interface SXHomeMainSectionHeaderView ()

@property (weak, nonatomic) UILabel *titleL;
    
@end

@implementation SXHomeMainSectionHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    
    SXHomeMainSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SXHomeMainSectionHeaderViewID];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:SXHomeMainSectionHeaderViewID];
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
    titleL.textColor = SXColor33333;
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
    
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}
    
@end
