//
//  SXPhotoListCollectionViewCell.m
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoListCell.h"

@interface SXPhotoListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end

@implementation SXPhotoListCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:SXPhotoListCollectionViewCellID forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorBlue;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.photoImageView.image = image;
}

@end
