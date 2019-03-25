//
//  SXPhotoController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoController.h"
#import "SXPhotoIntelligentController.h"
#import "SXPhotoShareController.h"
#import "SXPhotoSectionHeaderView.h"
#import "SXPhotoListCell.h"
#import "SXAlbumAuthorizationTool.h"
#import "SXAlertControllerTool.h"
#import <Photos/Photos.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import "SXPhotoHeaderView.h"

@interface SXPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXPhotoController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self checkAlbumAuthorization];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"相册";
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
    float collectionWidth = (SCREEN_WIDTH - 5 * 10)/4;
    layout.itemSize = CGSizeMake(collectionWidth, collectionWidth);
    
    //设置每一行之间的间距
    CGFloat inset = (SCREEN_WIDTH - 4 * layout.itemSize.width) / (4 + 1) - 1;
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    layout.minimumLineSpacing = inset;
    
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
    
    self.collectionView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
//    self.collectionView.backgroundColor = UIColor.redColor;
    
    PYAblum *ablumManager = [PYAblum defaultAblum];
    DLog(@"%ld",ablumManager.allPhotoAblumModelArray.count);
    NSArray *fdfdfd = [ablumManager sortWithModelArray:ablumManager.allPhotoAblumModelArray andIsASC:YES];
    DLog(@"dfdf%@",fdfdfd);
    for (PYAssetModel *model in ablumManager.allPhotoAblumModelArray) {
        UIImage *img = model.degradedImage;
        DLog(@"img:%@",img);
        
    }
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

#pragma mark -相册授权-
- (void)checkAlbumAuthorization{
    WS(weakSelf);
    [SXAlbumAuthorizationTool checkAlbumAuthorization:^(NSInteger status) {
        if (status != 3) {//没有授权，去请求授权
            [SXAlbumAuthorizationTool requestAlbumAuthorizationSuccess:^{
                DLog(@"请求成功");
                //直接读取
                DLog(@"读取数据");
                [self readDataHome];
            } failure:^{
                DLog(@"请求失败");
                [weakSelf alertSettingView];
            }];
        } else{
            //直接读取
            DLog(@"读取数据");
            [self readDataHome];
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
    PHFetchResult *images = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:options];
    
    NSInteger count = assetsFetchResults.count;
    NSInteger imgcount = images.count;
    DLog(@"%ld-%ld",count,imgcount);
    
    // 在资源的集合中获取第一个集合，并获取其中的图片
    PHImageManager *imageManager = [PHImageManager defaultManager];
    //    PHAsset *asset = assetsFetchResults[0];
    
    for (PHAsset *asset in assetsFetchResults) {
        [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            // 得到一张 UIImage，展示到界面上
            DLog(@"%@-%@",result,info);
            [self.dataArray addObject:result];
        }];
    }
    
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

- (void)readData{
    
    [[TZImageManager manager] getAllAlbums:YES allowPickingImage:YES needFetchAssets:YES completion:^(NSArray<TZAlbumModel *> *models) {
        
        for (TZAlbumModel *model in models) {
            PHFetchResult *result = model.result;
            NSArray *models = model.models;
            DLog(@"models:%@",models);
        }
    }];
}

#pragma mark -Event-
- (void)clickOptionBtn:(NSInteger)tag{
    switch (tag) {
        case 0:
            DLog(@"tag:%ld",tag);
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
    PYAblum *ablumManager = [PYAblum defaultAblum];
    DLog(@"%ld",ablumManager.allPhotoAblumModelArray.count);
//    return 1;
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else {
        return self.dataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXPhotoListCell *cell = [SXPhotoListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    UIImage *image = self.dataArray[indexPath.item];
    cell.image = image;
    return cell;
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
        return CGSizeMake(SCREEN_WIDTH,212);
    } else {
        return CGSizeZero;
    }
    return CGSizeZero;
}

//配置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        SXPhotoSectionHeaderView *headerView = [SXPhotoSectionHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
        headerView.title = [NSString stringWithFormat:@"标题-%ld",indexPath.section-1];
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
    
    DLog(@"section%ld->item:%ld",indexPath.section,indexPath.item);
}

@end
