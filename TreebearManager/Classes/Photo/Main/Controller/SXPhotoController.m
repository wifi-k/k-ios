//
//  SXPhotoController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoController.h"
#import "SXPhotoSectionHeaderView.h"
#import "SXPhotoListCell.h"
#import "SXAlbumAuthorizationTool.h"
#import "SXAlertControllerTool.h"

@interface SXPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation SXPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SXColorRandom;
    
    self.navigationItem.title = @"相册";
    
    DLog(@"-SXPhotoController-");
    
    [self setUpUI];
    
    [self checkAlbumAuthorization];
}

- (void)setUpUI{
    
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
    collectV.showsVerticalScrollIndicator = YES;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = SXColorGray7;
    collectV.alwaysBounceVertical = YES;
    [self.view addSubview:collectV];
    self.collectionView = collectV;
    
    //注册区头
//    [_collectionView registerClass:[SXPhotoSectionHeaderView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView"];
    
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SXPhotoListCell.class) bundle:nil] forCellWithReuseIdentifier:SXPhotoListCollectionViewCellID];
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
            } failure:^{
                DLog(@"请求失败");
                [weakSelf alertSettingView];
            }];
        } else{
            //直接读取
            DLog(@"读取数据");
        }
    }];
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

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXPhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SXPhotoListCollectionViewCellID forIndexPath:indexPath];
    return cell;
}

//设置区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH,50);
}

//设置区尾高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

//配置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        
//        SXPhotoSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView" forIndexPath:indexPath];
        SXPhotoSectionHeaderView *headerView = [SXPhotoSectionHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor redColor];
        headerView.title = [NSString stringWithFormat:@"标题-%ld",indexPath.section];
        return headerView;
        
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath.item:%ld",indexPath.item);
}

@end
