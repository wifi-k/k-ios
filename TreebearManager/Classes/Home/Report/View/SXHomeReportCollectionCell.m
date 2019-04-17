//
//  SXHomeReportCollectionCell.m
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportCollectionCell.h"

@interface SXHomeReportCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@end

@implementation SXHomeReportCollectionCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorWhite;
    
    self.nameL.textColor = SXColor2B3852;
}

#pragma mark -setter-
- (void)setUpData{
    self.nameL.text = @"";
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"img_login_icon"] options:SDWebImageRetryFailed];
}

@end
