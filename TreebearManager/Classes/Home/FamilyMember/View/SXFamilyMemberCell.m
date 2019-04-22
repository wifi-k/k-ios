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
    
    self.nickNameL.textColor = SXColor2B3852;
    self.mobileL.textColor = SXColor7383A2;
    
    [self.iconImageView roundViewWithRadius:25.0f];
}

#pragma mark -setter-
- (void)setModel:(SXFamilyMemberModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"mine_xioaki_default2"] options:SDWebImageRetryFailed];
    
    NSString *nameStr = @"";
    if ([NSString isNotEmpty:model.userMobile] && model.userMobile.length > 4) {
        NSRange range = NSMakeRange(model.userMobile.length-4, 4);
        NSString *subMobile = [model.userMobile substringWithRange:range];
        nameStr = [NSString isEmpty:model.userName] ? [NSString stringWithFormat:@"用户%@",subMobile] : model.userName;
    }
    self.nickNameL.text = nameStr;

    self.mobileL.text = [NSString stringWithFormat:@"手机号：%@",model.userMobile];
    if (model.role.integerValue == 0) {//超级管理员
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_manager_super2"] forState:UIControlStateNormal];
        self.deleteBtn.enabled = NO;
    } else {//普通
        [self.deleteBtn setImage:[UIImage imageNamed:@"home_manager_delete"] forState:UIControlStateNormal];
        self.deleteBtn.enabled = YES;
        self.deleteBtn.hidden = !model.isManager;
    }
}

#pragma mark -点击事件-
- (IBAction)clickDeleteBtn:(UIButton *)sender {
    if (self.clickDeleteBtnBlock) {
        self.clickDeleteBtnBlock(self.model);
    }
}

@end

