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
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressL;
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
    
    self.progressView.tintColor = [UIColor colorWithRed:55/255.0 green:237/255.0 blue:163/255.0 alpha:0.6];
    self.progressView.trackTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    
    self.progressL.text = @"10%";
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
