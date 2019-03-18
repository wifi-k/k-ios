//
//  SXMineChildCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXMineChildCell.h"

@interface SXMineChildCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@end

@implementation SXMineChildCell

static NSArray *_imageNameArr = nil;//提示文字容器

+ (void)initialize{
    if (!_imageNameArr) {
        _imageNameArr = @[@"img_child_ icon1",
                          @"img_child_ icon2"];
    }
}

static NSString *SXMineChildCellID = @"SXMineChildCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXMineChildCellID];
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
    self.contentView.backgroundColor = SXColorWhite;
   
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

- (void)setModel:(SXMineChildModel *)model{
    _model = model;
    
    self.nameL.text = model.title;
    NSInteger index = model.row.integerValue % 2;
    self.iconImageView.image = [UIImage imageNamed:_imageNameArr[index]];
}

@end
