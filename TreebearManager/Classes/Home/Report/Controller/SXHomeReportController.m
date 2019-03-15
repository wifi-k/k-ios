//
//  SXHomeReportController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXHomeReportController.h"
#import "SXHomeReportReusableView.h"
#import "SXHomeReportCollectionCell.h"

@interface SXHomeReportController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;//滚动视图
@end

@implementation SXHomeReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"周报";
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    float collectionWidth = (SCREEN_WIDTH - 3 * 10)/4;
    layout.itemSize = CGSizeMake(collectionWidth, collectionWidth);
    
    //设置每一行之间的间距
    CGFloat inset = (SCREEN_WIDTH - 2 * layout.itemSize.width) / (2 + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    layout.minimumLineSpacing = inset;
    
    //创建collectionView
    UICollectionView *collectV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectV.dataSource = self;
    collectV.delegate = self;
    collectV.showsVerticalScrollIndicator = YES;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = SXColorBgViewGray;
    collectV.alwaysBounceVertical = YES;
    [self.view addSubview:collectV];
    self.collectionView = collectV;
    
    //1.注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SXHomeReportCollectionCell.class) bundle:nil] forCellWithReuseIdentifier:SXHomeReportCollectionCellID];
    
    //1.注册分组头部视图(第一分组,头部)
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SXHomeReportReusableView.class) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SXHomeReportReusableViewID];
}

- (void)viewDidLayoutSubviews{
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //控制尾部加载视图隐藏显示
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return UIEdgeInsetsZero;//分别为上、左、下、右
    }
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        float collectionWidth = (SCREEN_WIDTH - 3 * 10)/4;
        return CGSizeMake(collectionWidth, collectionWidth);
    }
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SXHomeReportCollectionCell *cell = [SXHomeReportCollectionCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath:%ld-%ld",indexPath.section,indexPath.row);
}

#pragma mark -UICollectionViewDelegateFlowLayout方法-
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){SCREEN_WIDTH,250};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {//头部视图
        SXHomeReportReusableView *reusableView = [SXHomeReportReusableView sectionHeaderWithCollectionView:collectionView atIndexPath:indexPath];
        return reusableView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){//底部视图
        return nil;
    }else{
        return nil;
    }
    return nil;
}

@end
