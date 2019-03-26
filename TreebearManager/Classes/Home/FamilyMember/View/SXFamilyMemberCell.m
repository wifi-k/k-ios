//
//  SXFamilyMemberCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/3.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXFamilyMemberCell.h"

@interface SXFamilyMemberCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameL;
@property (weak, nonatomic) IBOutlet UILabel *mobileL;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXFamilyMemberCell

static NSString *SXFamilyMemberCellID = @"SXFamilyMemberCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXFamilyMemberCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
}

#pragma mark -setter-
- (void)setModel:(SXFamilyMemberModel *)model{
    _model = model;
    
    self.nickNameL.text = [NSString stringWithFormat:@"昵称：%@",model.userName];
    self.mobileL.text = [NSString stringWithFormat:@"手机号：%@",model.userMobile];
}

#pragma mark -点击事件-
- (IBAction)clickDeleteBtn:(UIButton *)sender {
    if (self.clickDeleteBtnBlock) {
        self.clickDeleteBtnBlock(self.model);
    }
}

@end

