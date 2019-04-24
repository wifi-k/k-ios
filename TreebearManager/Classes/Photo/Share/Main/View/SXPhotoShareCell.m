//
//  SXPhotoShareCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoShareCell.h"

@interface SXPhotoShareCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@end

@implementation SXPhotoShareCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass(self);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

#pragma mark -UI-
- (void)setUpUI{
    
    //设置背景色
    self.backgroundColor = SXColorWhite;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.bottomBgView roundViewWithRadius:8.0f];
}

@end
