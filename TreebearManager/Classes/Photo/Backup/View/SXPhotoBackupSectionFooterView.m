//
//  SXPhotoBackupSectionFooterView.m
//  TreebearManager
//
//  Created by bear on 2019/4/9.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBackupSectionFooterView.h"

@interface SXPhotoBackupSectionFooterView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoCountL;
@property (weak, nonatomic) IBOutlet UILabel *speedL;
@property (weak, nonatomic) IBOutlet UIView *devideLineView;

@property (weak, nonatomic) IBOutlet UILabel *diskL;
@property (weak, nonatomic) IBOutlet UILabel *diskCountL;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation SXPhotoBackupSectionFooterView

+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    
    self.photoCountL.textColor = SXColor2B3852;
    self.speedL.textColor = SXColor2B3852;
    
    self.devideLineView.backgroundColor = SXColorDivideLine;
    self.devideLineView.height = 0.5;
    
    self.diskL.textColor = SXColor2B3852;
    self.diskCountL.textColor = SXColor7383A2;
    
    self.progressView.tintColor = SXColorBlue;
    self.progressView.trackTintColor = [UIColor hex:@"EEEEEE"];
}

@end
