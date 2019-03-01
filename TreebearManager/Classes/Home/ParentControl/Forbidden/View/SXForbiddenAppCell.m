//
//  SXForbiddenAppCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppCell.h"

@interface SXForbiddenAppCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@end

@implementation SXForbiddenAppCell

static NSString *SXForbiddenAppCellID = @"SXForbiddenAppCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXForbiddenAppCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    self.contentView.backgroundColor = SXColorWhite;
    
    //1.家庭码背景视图
    //self.contentBgView.layer.masksToBounds=YES;这行去掉
    self.contentBgView.backgroundColor = [UIColor whiteColor];
    self.contentBgView.layer.cornerRadius = 3;
    self.contentBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.contentBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.contentBgView.layer.shadowOpacity = 0.5;
    self.contentBgView.layer.shadowRadius = 3;
}

#pragma mark -setter方法-
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleL.text = title;
}

#pragma mark -点击事件-
- (IBAction)clickEditBtn:(UIButton *)sender {
    if (self.clickEditBtnBlock) {
        self.clickEditBtnBlock();
    }
}

- (IBAction)clickDeleteBtn:(UIButton *)sender {
    if (self.clickDeleteBtnBlock) {
        self.clickDeleteBtnBlock();
    }
}

@end
