//
//  SXTimeControlCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTimeControlCell.h"

@interface SXTimeControlCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@end

@implementation SXTimeControlCell

static NSArray *_imageNameArr = nil;//提示文字容器

+ (void)initialize{
    if (!_imageNameArr) {
        _imageNameArr = @[@"img_forbidden_ scheme1",
                          @"img_forbidden_ scheme2",
                          @"img_forbidden_ scheme3"];
    }
}

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
    self.contentBgView.layer.cornerRadius = 5;
    self.contentBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.contentBgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.contentBgView.layer.shadowOpacity = 0.5;
    self.contentBgView.layer.shadowRadius = 3;
    [self.contentBgView borderColor:UIColor.lightGrayColor borderWidth:0.1];
}

#pragma mark -setter方法-
- (void)setModel:(SXForbiddenAppModel *)model{
    _model = model;
    
    self.titleL.text = model.title;
    NSInteger index = model.row.integerValue % 3;
    self.iconImageView.image = [UIImage imageNamed:_imageNameArr[index]];
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