//
//  SXPhotoBrowserCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserCell.h"

@interface SXPhotoBrowserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end

@implementation SXPhotoBrowserCell

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

#pragma mark -UI-
- (void)setUpUI{
    
    self.contentView.backgroundColor = SXColorWhite;
    self.contentView.contentMode = UIViewContentModeScaleToFill;
}

#pragma mark -setter-
- (void)setAsset:(PHAsset *)asset{
    _asset = asset;
    
    WS(weakSelf);
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.photoImageView.image = result;
    }];
}

@end
