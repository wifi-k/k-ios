//
//  SXTimeOptionController.m
//  TreebearManager
//
//  Created by bear on 2019/3/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXForbiddenAppOptionController.h"
#import "SXForbiddenAppOptionCell.h"

@interface SXForbiddenAppOptionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
///数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXForbiddenAppOptionController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            SXForbiddenAppOptionModel *model = [[SXForbiddenAppOptionModel alloc] init];
            model.title = [NSString stringWithFormat:@"名称%d",i];
            model.row= @(i);
            model.selected = @(NO);
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    
    self.view.backgroundColor = SXColorBgViewGray;
    
    self.navigationItem.title = @"选择禁用的APP";
    
    UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithTitle:@"保存" target:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = right;
    
    int count = 3;
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //layout.sectionHeadersPinToVisibleBounds = YES;//头视图悬浮
    float collectionWidth = (SCREEN_WIDTH - (count+1) * 10)/count;
    layout.itemSize = CGSizeMake(collectionWidth, 150);
    
    //设置每一行之间的间距
    CGFloat inset = (SCREEN_WIDTH - count * layout.itemSize.width) / (count + 1) - 1;
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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SXForbiddenAppOptionCell.class) bundle:nil] forCellWithReuseIdentifier:SXForbiddenAppOptionCellID];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.collectionView.frame = self.view.bounds;
}

- (void)rightButtonAction:(UIButton *)button{
    [MBProgressHUD showMessage:@"保存成功!" toView:self.view];
    if (self.selectForbiddenOptionBlock) {
        NSString *fdfdf = [NSString stringWithFormat:@"%@个",10];
        self.selectForbiddenOptionBlock(fdfdf);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 2;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXForbiddenAppOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SXForbiddenAppOptionCellID forIndexPath:indexPath];
    SXForbiddenAppOptionModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    return cell;
}

////设置区头高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(SCREEN_WIDTH,50);
//}

//设置区尾高度
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeZero;
//}

//配置区头
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
//    if (kind == UICollectionElementKindSectionHeader) {
//        SXPhotoSectionHeaderView *headerView = [SXPhotoSectionHeaderView sectionHeaderAwakeFromClass:collectionView atIndexPath:indexPath];
//        //        headerView.backgroundColor = [UIColor redColor];
//        headerView.title = [NSString stringWithFormat:@"标题-%ld",indexPath.section];
//        return headerView;
//
//    }
//    return nil;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath.item:%ld",indexPath.item);
    
    SXForbiddenAppOptionModel *model = self.dataArray[indexPath.row];
    model.selected = @(!model.selected.boolValue);
    
    //刷新数组
    [self.collectionView reloadData];
}

@end
