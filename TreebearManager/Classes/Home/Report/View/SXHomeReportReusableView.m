//
//  SXHomeReportReusableView.m
//  TreebearManager
//
//  Created by bear on 2019/3/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportReusableView.h"

@interface SXHomeReportReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UIView *chartBgView;

@property (weak, nonatomic) IBOutlet UILabel *appL;
@end

@implementation SXHomeReportReusableView

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
    
    self.timeL.font = SXFontBold18;
    self.appL.font = SXFontBold18;
    
    self.timeL.textColor = SXColor333333;
    self.appL.textColor = SXColor333333;
    
    self.chartBgView.backgroundColor = [UIColor whiteColor];
    self.chartBgView.layer.cornerRadius = 5;
    self.chartBgView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
    self.chartBgView.layer.shadowOffset = CGSizeMake(0, 5);
    self.chartBgView.layer.shadowOpacity = 0.5;
    self.chartBgView.layer.shadowRadius = 5;
}

@end
