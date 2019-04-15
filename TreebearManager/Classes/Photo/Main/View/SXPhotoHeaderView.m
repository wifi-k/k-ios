//
//  SXPhotoHeaderView.m
//  TreebearManager
//
//  Created by bear on 2019/3/24.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoHeaderView.h"
#import "SXPhotoHeaderButton.h"

@interface SXPhotoHeaderView ()
@property (weak, nonatomic) IBOutlet SXPhotoHeaderButton *latestBtn;
@property (weak, nonatomic) IBOutlet SXPhotoHeaderButton *intelligentBtn;
@property (weak, nonatomic) IBOutlet SXPhotoHeaderButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *backupBgView;
@end

@implementation SXPhotoHeaderView

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
    
    self.topBgView.backgroundColor = SXColorWhite;
    
    self.backupBgView.backgroundColor = [UIColor whiteColor];
    self.backupBgView.layer.cornerRadius = 4;
    self.backupBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.backupBgView.layer.shadowOffset = CGSizeMake(0, 2);
    self.backupBgView.layer.shadowOpacity = 0.5;
    self.backupBgView.layer.shadowRadius = 2;
    self.backupBgView.backgroundColor = SXColorWhite;
    
    self.contentL.textColor = SXColor2B3852;
    [self.confirmBtn setTitleColor:SXColorBlue forState:UIControlStateNormal];
    [self.confirmBtn roundViewWithRadius:15.0f borderColor:SXColorBlue borderWidth:1.0f];

}

#pragma mark -Event-
- (IBAction)clickOptionBtn:(SXPhotoHeaderButton *)sender {
    if (self.clickOptionBtnBlock) {
        self.clickOptionBtnBlock(sender.tag);
    }
}

- (IBAction)clickBackupBtn:(UIButton *)sender {
    if (self.clickBackupBtnBlock) {
        self.clickBackupBtnBlock();
    }
}

@end
