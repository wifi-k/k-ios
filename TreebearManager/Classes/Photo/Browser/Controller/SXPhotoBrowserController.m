//
//  SXPhotoBrowserController.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserController.h"
#import "SXPhotoBrowserCell.h"

#define COL 3

@interface SXPhotoBrowserController ()<UICollectionViewDelegate,UICollectionViewDataSource>
///滚动视图
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation SXPhotoBrowserController

#pragma mark -life recycle-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置当前导航条背景色
    self.navigationController.navigationBar.barTintColor = UIColor.blackColor;
    
    //设置导航条文字颜色和大小
    NSMutableDictionary *barAttr = [NSMutableDictionary dictionary];
    barAttr[NSForegroundColorAttributeName] = UIColor.whiteColor;
    barAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
    [self.navigationController.navigationBar setTitleTextAttributes:barAttr];
    
    // 设置导航条的按钮
    [self.navigationItem.leftBarButtonItem.customButton setImage:[UIImage imageNamed:@"navi_left_white"] forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    
    //设置导航条文字颜色和大小
    NSMutableDictionary *barAttr = [NSMutableDictionary dictionary];
    barAttr[NSForegroundColorAttributeName] = UIColor.blackColor;
    barAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
    [self.navigationController.navigationBar setTitleTextAttributes:barAttr];
    
    // 设置导航条的按钮
    [self.navigationItem.leftBarButtonItem.customButton setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = UIColor.blackColor;
//    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"图片浏览";
    
//    NSArray *sectionArr = self.assetArray[self.indexPath.section];
//    PHAsset *asset = sectionArr[self.indexPath.row];
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
    
    //设置每一行之间的间距
//        CGFloat inset = (SCREEN_WIDTH - COL * layout.itemSize.width) / (COL + 1);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    layout.minimumLineSpacing = 2;
//    layout.minimumInteritemSpacing = 2;
    
    //创建collectionView
    UICollectionView *collectV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectV.dataSource = self;
    collectV.delegate = self;
    collectV.pagingEnabled = YES;
    collectV.bounces = NO;
    collectV.showsVerticalScrollIndicator = NO;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectV];
    self.collectionView = collectV;
    
//    self.collectionView.pagingEnabled = YES;
//    self.collectionView.bounces = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.delegate = self;//设置代理
//    self.collectionView.dataSource = self;//设置代理
//    [self.collectionView registerClass:[DTNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
//分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.assetArray.count;
}

//第section组中有几个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionArr = self.assetArray[section];
    return sectionArr.count;
}

//返回cell长啥样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SXPhotoBrowserCell *cell = [SXPhotoBrowserCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    NSArray *sectionArr = self.assetArray[indexPath.section];
    PHAsset *asset = sectionArr[indexPath.item];
    cell.asset = asset;
    return cell;
}

//设置区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

//设置区尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

@end
