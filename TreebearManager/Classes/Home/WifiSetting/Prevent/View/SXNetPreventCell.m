//
//  SXNetWallCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXNetPreventCell.h"

@interface SXNetPreventCell ()
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@end

@implementation SXNetPreventCell

static NSString *SXNetWallCellID = @"SXNetWallCellID";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    id cell = [tableView dequeueReusableCellWithIdentifier:SXNetWallCellID];
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
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.bottomLineView.backgroundColor = SXColorDivideLine;
    self.bottomLineView.height = 0.5;
    
    //缩放
    //self.switchBtn.transform = CGAffineTransformMakeScale( 0.8, 0.8);
    self.switchBtn.onTintColor = SXColorBlue2;
}

@end
