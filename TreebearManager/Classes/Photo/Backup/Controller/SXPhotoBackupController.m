
//
//  SXPhotoBackupController.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBackupController.h"
#import "SXPhotoListCell.h"

#define COL 3

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
    float collectionWidth = (SCREEN_WIDTH - (COL+1) * 1)/COL;
    layout.itemSize = CGSizeMake(collectionWidth, collectionWidth);
    
    //设置每一行之间的间距
    //    CGFloat inset = (SCREEN_WIDTH - COL * layout.itemSize.width) / (COL + 1);
    //    layout.sectionInset = UIEdgeInsetsMake(inset, 0, inset, 0);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    
    //创建collectionView
    UICollectionView *collectV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectV.dataSource = self;
    collectV.delegate = self;
    collectV.showsVerticalScrollIndicator = NO;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = SXColorGray7;
    collectV.alwaysBounceVertical = YES;
    [self.view addSubview:collectV];
    self.collectionView = collectV;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
//分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//第section组中有几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//返回cell长啥样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SXPhotoListCell *cell = [SXPhotoListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    PHAsset *asset = self.dataArray[indexPath.item];
    cell.asset = asset;
    return cell;
}

@end
