//
//  SXTimeControlAddCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlAddCell.h"

@interface SXTimeControlAddCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@end

@implementation SXTimeControlAddCell

static NSString *SXTimeControlAddCellID = @"SXTimeControlAddCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXTimeControlAddCellID];
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
    
    self.titleL.font = SXFontBold16;
    
    //1.家庭码背景视图
    //self.contentBgView.layer.masksToBounds=YES;这行去掉
    self.contentBgView.backgroundColor = [UIColor whiteColor];
    self.contentBgView.layer.cornerRadius = 5;
    self.contentBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.contentBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.contentBgView.layer.shadowOpacity = 0.5;
    self.contentBgView.layer.shadowRadius = 3;
    [self.contentBgView borderColor:UIColor.lightGrayColor borderWidth:0.1];
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
