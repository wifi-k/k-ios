//
//  SXPhotoBackupSectionHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/4/10.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBackupSectionHeaderView.h"

@interface SXPhotoBackupSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *backupBtn;
@end

@implementation SXPhotoBackupSectionHeaderView

+ (instancetype)sectionHeaderAwakeFromNib:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass(self);
    UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
    [collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}

//初始化UI
- (void)setUpUI{
    
    self.backgroundColor = SXColorWhite;
    self.titleL.textColor = SXColor333333;
    [self.backupBtn setTitleColor:SXColorBlue forState:UIControlStateNormal];
}

#pragma mark -Event-
- (IBAction)clickBackupBtn:(UIButton *)sender {
    if (self.clickBackupBtnBlock) {
        self.clickBackupBtnBlock();
    }
}

@end
