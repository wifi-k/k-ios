
//
//  SXPhotoBackupController.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBackupController.h"
#import "SXPhotoBackupSectionHeaderView.h"
#import "SXPhotoBackupSectionFooterView.h"
#import "SXPhotoBackupCollectionCell.h"

#define COL 3
static CGFloat marginX = 1.0f;
static CGFloat marginY = 1.0f;

@interface SXPhotoBackupController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation SXPhotoBackupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"照片备份";
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
    
    //设置每一行之间的间距
    //    CGFloat inset = (SCREEN_WIDTH - COL * layout.itemSize.width) / (COL + 1);
    //    layout.sectionInset = UIEdgeInsetsMake(inset, 0, inset, 0);
    float itemWidth = (SCREEN_WIDTH - (COL+1) * marginX)/COL;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);//设置单元格大小
    layout.minimumLineSpacing = marginY*2; //最小行间距(默认为10)
    layout.minimumInteritemSpacing = marginX; //最小item间距（默认为10）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置senction的内边距
    
    //创建collectionView
    UICollectionView *collectV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectV.dataSource = self;
    collectV.delegate = self;
    collectV.showsVerticalScrollIndicator = NO;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = SXColorWhite;
    collectV.alwaysBounceVertical = YES;
    [self.view addSubview:collectV];
    self.collectionView = collectV;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
//分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1+1;
}

//第section组中有几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else {
        return self.dataArray.count;
    }
}

//返回cell长啥样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 0;
    } else {
        SXPhotoBackupCollectionCell *cell = [SXPhotoBackupCollectionCell cellWithCollectionView:collectionView atIndexPath:indexPath];
        SXAsset *asset = self.dataArray[indexPath.item];
        cell.asset = asset;
        return cell;
    }
}

//设置区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH,50);
}

//设置区尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH,170);
    } else {
        return CGSizeZero;
    }
    return CGSizeZero;
}

//配置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        SXPhotoBackupSectionHeaderView *headerView = [SXPhotoBackupSectionHeaderView sectionHeaderAwakeFromNib:collectionView atIndexPath:indexPath];
        headerView.clickBackupBtnBlock = ^{
            DLog("暂停备份...");
            [MBProgressHUD showWarningWithMessage:@"备份中..." toView:SXKeyWindow];
        };
        return headerView;
    } else if(kind == UICollectionElementKindSectionFooter){
        SXPhotoBackupSectionFooterView *reusableView = [SXPhotoBackupSectionFooterView sectionHeaderAwakeFromNib:collectionView atIndexPath:indexPath];
        return reusableView;
    }
    return nil;
}

@end
