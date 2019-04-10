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
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@end

@implementation SXPhotoListCell

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
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.contentView addGestureRecognizer:longPress];
}

// 长按图片的时候就会触发长按手势
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    if (self.asset.isChecked) return;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        DLog(@"%ld",longPress.state);
        self.asset.isChecked = YES;
        self.checkImageView.image = [UIImage imageNamed:@"home_netoption_check"];
        if (self.longPressBlock) {
            self.longPressBlock();
        }
    }
}

#pragma mark -setter-
- (void)setAsset:(SXAsset *)asset{
    _asset = asset;
 
    WS(weakSelf);
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset.asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakSelf.photoImageView.image = result;
    }];
    
    if (asset.isChecked) {
        self.checkImageView.image = [UIImage imageNamed:@"home_netoption_check"];
    } else {
        self.checkImageView.image = [UIImage imageNamed:@"home_netoption_uncheck"];
    }
}

@end
