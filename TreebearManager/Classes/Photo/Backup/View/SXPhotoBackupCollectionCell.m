//
//  SXPhotoBackupCollectionCell.m
//  TreebearManager
//
//  Created by bear on 2019/4/9.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBackupCollectionCell.h"

@interface SXPhotoBackupCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end

@implementation SXPhotoBackupCollectionCell

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
