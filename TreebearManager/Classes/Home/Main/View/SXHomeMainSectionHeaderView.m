//
//  SXHomeMainSectionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/2/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeMainSectionHeaderView.h"
#import "SXMobileManagerModel.h"

@interface SXHomeMainSectionHeaderView ()
@property (weak, nonatomic) UILabel *titleL;
@property (weak, nonatomic) UILabel *contentL;
@end

@implementation SXHomeMainSectionHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass(self);
    [tableView registerClass:self forHeaderFooterViewReuseIdentifier:identifier];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
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
    titleL.textColor = SXColor2B3852;
    [self.contentView addSubview:titleL];
    self.titleL = titleL;
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.font = SXFont14;
    contentL.textColor = SXColor7383A2;
    [self.contentView addSubview:contentL];
    self.contentL = contentL;
    
    self.titleL.text = @"连网设备";
    self.contentL.text = @"当前在线0台";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView).mas_offset(-15);
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView).mas_offset(15);
    }];
}

//赋值在线数量
- (void)totalOnLineCount:(NSInteger)count{
    self.contentL.text = [NSString stringWithFormat:@"当前在线%ld台/上行网速0K/下行网速0K",count];
}
    
@end
