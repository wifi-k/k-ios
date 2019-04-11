//
//  SXPhotoController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoController.h"
#import "SXPhotoBackupController.h"
#import "SXPhotoIntelligentController.h"
#import "SXPhotoShareController.h"
#import "SXPhotoBrowserController.h"
#import "SXPhotoSectionHeaderView.h"
#import "SXPhotoListCell.h"
#import "SXAlbumAuthorizationTool.h"
#import "SXAlertControllerTool.h"
#import "SXPhotoHeaderView.h"
#import "SXPhotoTopView.h"
#import "SXPhotoBottomView.h"
#import "SXAsset.h"

#define COL 3

@interface SXPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) SXPhotoTopView *topView;
@property (nonatomic, weak) UICollectionView *collectionView;

///数据源
@property (nonatomic, strong) NSMutableArray *assetArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
///是否编辑状态
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation SXPhotoController

#pragma mark -getter-
- (NSMutableArray *)assetArray{
    if (_assetArray == nil) {
        _assetArray = [NSMutableArray array];
    }
    return _assetArray;
}

- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self checkAlbumAuthorization];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"照片库";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"备份" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
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
    
    self.collectionView.backgroundColor = SXColorWhite;

    //顶部视图
    SXPhotoTopView *topView = [SXPhotoTopView topView];
    topView.frame = self.navigationController.navigationBar.bounds;
    [self.navigationController.navigationBar addSubview:topView];
    self.topView = topView;
    self.topView.hidden = YES;
    
    //底部视图
    SXPhotoBottomView *bottomView = [SXPhotoBottomView bottomView];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(self.tabBarController.tabBar.bounds.size);
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view.mas_bottom);
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view.mas_right);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//    }];
    
    self.collectionView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)btn{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSArray *sectionArr in self.assetArray) {
        for (PHAsset *asset in sectionArr) {
            [dataArray addObject:asset];
        }
    }
    SXPhotoBackupController *backVC = [[SXPhotoBackupController alloc] init];
    backVC.dataArray = dataArray;
    [self.navigationController pushViewController:backVC animated:YES];
}

#pragma mark -相册授权-
- (void)checkAlbumAuthorization{
    WS(weakSelf);
    [SXAlbumAuthorizationTool checkAlbumAuthorization:^(NSInteger status) {
        if (status != 3) {//没有授权，去请求授权
            [SXAlbumAuthorizationTool requestAlbumAuthorizationSuccess:^{
                DLog(@"请求成功");
                //直接读取
                DLog(@"读取数据");
                [weakSelf readDataHome];
            } failure:^{
                DLog(@"请求失败");
                [weakSelf alertSettingView];
            }];
        } else{
            //直接读取
            DLog(@"读取数据");
            [weakSelf readDataHome];
        }
    }];
}

- (void)readDataHome{
    
    // 列出所有相册智能相册
    //    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 列出所有用户创建的相册
    //    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
    options.sortDescriptors = @[sort];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    //PHFetchResult *imagesAssetsResults = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    
    //遍历之前先清空
    [self.assetArray removeAllObjects];
    [self.titleArray removeAllObjects];
    WS(weakSelf);
    __block NSMutableArray *sectionArr;
    [assetsFetchResults enumerateObjectsUsingBlock:^(PHAsset  * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
        DLog(@"asset:%@",asset);
        //类型转换
        SXAsset *asset0 = [[SXAsset alloc] init];
        asset0.asset = asset;
        asset0.isChecked = NO;
        
        NSDate *date = asset0.asset.creationDate;
        NSDateFormatter *dateformatter  = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [dateformatter stringFromDate:date];
        if ([weakSelf.titleArray containsObject:dateString]) {
            [sectionArr addObject:asset0];
        } else {//创建分组
            [weakSelf.titleArray addObject:dateString];
            
            sectionArr = [NSMutableArray array];
            [weakSelf.assetArray addObject:sectionArr];
            [sectionArr addObject:asset0];
        }
    }];
    [self.collectionView reloadData];
}

#pragma mark -系统弹窗提示-
- (void)alertSettingView{
    [SXAlertControllerTool alertWithTitle:@"提示" message:@"您的相册访问权限未开启，请到手机隐私设置" confirm:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    } cancel:^(UIAlertAction * _Nonnull action) {
        DLog(@"action.title:%@",action.title);
    }];
}

#pragma mark -Event-
- (void)clickOptionBtn:(NSInteger)tag{
    switch (tag) {
        case 0:
            [MBProgressHUD showWhiteLoadingWithMessage:@"" toView:SXKeyWindow];
#warning mark -测试使用-
            [self readDataHome];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
            });
            break;
        case 1:{
            SXPhotoIntelligentController *intelligentVC = [[SXPhotoIntelligentController alloc] init];
            [self.navigationController pushViewController:intelligentVC animated:YES];
        }
            break;
        case 2:{
            SXPhotoShareController *intelligentVC = [[SXPhotoShareController alloc] init];
            [self.navigationController pushViewController:intelligentVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- iOS 8.0 以上获取所有照片用Photos.h这个库
-(NSMutableArray*)GetALLphotosUsingPohotKit
{
    NSMutableArray *arr = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 是否按创建时间排序
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            //            if ([collection.localizedTitle isEqualToString:@"Favorites"]) {
            //
            //            }
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            NSArray *assets;
            if (fetchResult.count > 0) {
                // 某个相册里面的所有PHAsset对象
                assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES ];
                [arr addObjectsFromArray:assets];
            }
        }
    }
    //返回相机胶卷内的所有照片
    return arr;
}

#pragma mark - <  根据PHAsset获取图片信息  >
- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image,NSDictionary *info))completion{
    
    static PHImageRequestID requestID = -2;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, 500);
    if (requestID >= 1 && size.width / width == scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    //    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.resizeMode = resizeMode;
    
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(result,info);
        });
    }];
}

#pragma mark - <  获取相册里的所有图片的PHAsset对象  >
- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    // 存放所有图片对象
    NSMutableArray *assets = [NSMutableArray array];
    
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    // 获取所有图片对象
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    // 遍历
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
        
        [self accessToImageAccordingToTheAsset:asset size:CGSizeMake(100, 100) resizeMode:PHImageRequestOptionsResizeModeNone completion:^(UIImage *image, NSDictionary *info) {
            
        }];
    }];
    return assets;
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.assetArray.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else {
        NSArray *sectionArr = self.assetArray[section-1];
        return sectionArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    SXPhotoListCell *cell = [SXPhotoListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    NSArray *sectionArr = self.assetArray[indexPath.section-1];
    SXAsset *asset = sectionArr[indexPath.item];
    cell.asset = asset;
    cell.longPressBlock = ^{
        DLog(@"长按手势...");
        weakSelf.isEditing = YES;
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [collectionView reloadSections:indexSet];
        
        [weakSelf.tabBarController.tabBar setHidden:YES];
        weakSelf.topView.hidden = NO;
    };
    return cell;
}

//设置分组头部高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH,50);
}

//设置分组尾部高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.isEditing) {
            return CGSizeZero;
        } else {
            return CGSizeMake(SCREEN_WIDTH,212);
        }
    } else {
        return CGSizeZero;
    }
    return CGSizeZero;
}

//设置分组头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        SXPhotoSectionHeaderView *headerView = [SXPhotoSectionHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
        headerView.title = self.titleArray[indexPath.section-1];
        return headerView;
    } else if(kind == UICollectionElementKindSectionFooter){
        WS(weakSelf);
        SXPhotoHeaderView *reusableView = [SXPhotoHeaderView sectionHeaderAwakeFromNib:collectionView atIndexPath:indexPath];
        reusableView.clickBackupBtnBlock = ^{
            [MBProgressHUD showMessage:@"开始备份" toView:SXKeyWindow];
        };
        reusableView.clickOptionBtnBlock = ^(NSInteger tag) {
            [weakSelf clickOptionBtn:tag];
        };
        return reusableView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"section%ld->item:%ld",indexPath.section-1,indexPath.item);
    
    NSArray *sectionArr = self.assetArray[indexPath.section-1];
    SXAsset *asset = sectionArr[indexPath.item];
    if (asset.isChecked || self.isEditing == YES) {
        asset.isChecked = !asset.isChecked;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
        NSInteger count = 0;
        NSInteger noCheckCount = 0;
        for (NSArray *sectionArr in self.assetArray) {
            for (SXAsset *asset in sectionArr) {
                ++count;
                if (asset.isChecked) {
                    return;
                } else {
                    ++noCheckCount;
                }
            }
        }
        
        if (noCheckCount == count) {
            self.isEditing = NO;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
            [collectionView reloadSections:indexSet];
            [self.tabBarController.tabBar setHidden:NO];
            self.topView.hidden = YES;
        }
        return;
    }
    
    SXPhotoBrowserController *browserVC = [[SXPhotoBrowserController alloc] init];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSArray *sectionArr in self.assetArray) {
        for (SXAsset *asset in sectionArr) {
            [dataArray addObject:asset];
        }
    }
    NSInteger row = 0;
    for (int i=0; i<indexPath.section-1; i++) {
        NSArray *sectionArr = self.assetArray[i];
        row += sectionArr.count;
    }
    row += indexPath.item;
    NSIndexPath *indexPath0 = [NSIndexPath indexPathForItem:row inSection:0];
    browserVC.dataArray = dataArray;
    browserVC.indexPath = indexPath0;
    [self.navigationController pushViewController:browserVC animated:YES];
}

@end
