//
//  SXPhotoChooseController.m
//  TreebearManager
//
//  Created by bear on 2019/4/12.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoChooseController.h"
#import "SXPhotoBackupController.h"
#import "SXPhotoIntelligentController.h"
#import "SXPhotoShareController.h"
#import "SXPhotoBrowserController.h"
#import "SXPhotoSectionHeaderView.h"
#import "SXPhotoListCell.h"
#import "SXAlbumAuthorizationTool.h"
#import "SXAlertControllerTool.h"
#import "SXAsset.h"

#define COL 3

@interface SXPhotoChooseController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;

///数据源
@property (nonatomic, strong) NSMutableArray *assetArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation SXPhotoChooseController

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
    
    self.navigationItem.title = @"选择照片";
    
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
    collectV.backgroundColor = SXColorWhite;
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
    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view);
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
        asset0.isShow = YES;
        
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
            [self readDataHome];
            [MBProgressHUD showWhiteLoadingToView:SXKeyWindow];
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
    SXPhotoListCell *cell = [SXPhotoListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    NSArray *sectionArr = self.assetArray[indexPath.section-1];
    SXAsset *asset = sectionArr[indexPath.item];
    cell.asset = asset;
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
    return CGSizeZero;
}

//设置分组头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        SXPhotoSectionHeaderView *headerView = [SXPhotoSectionHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
        headerView.title = self.titleArray[indexPath.section-1];
        return headerView;
    } else if(kind == UICollectionElementKindSectionFooter){
        return nil;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"section%ld->item:%ld",indexPath.section-1,indexPath.item);
    
    NSArray *sectionArr = self.assetArray[indexPath.section-1];
    SXAsset *asset = sectionArr[indexPath.item];
    if (asset.isChecked) {
        asset.isChecked = !asset.isChecked;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
        NSInteger totalCount = 0;
        NSInteger checkCount = 0;
        for (NSArray *sectionArr in self.assetArray) {
            for (SXAsset *asset in sectionArr) {
                ++totalCount;
                if (asset.isChecked) {
                    ++checkCount;
                }
            }
        }
        
        if (checkCount == 0) {
            for (NSArray *sectionArr in self.assetArray) {
                for (SXAsset *asset in sectionArr) {
                    asset.isShow = YES;
                }
            }
            [self.collectionView reloadData];
            [self.tabBarController.tabBar setHidden:NO];
        } else {
            
        }
        return;
    } else {
        asset.isChecked = !asset.isChecked;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

@end
