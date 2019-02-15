//
//  SXPhotoController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoController.h"
#import "SXPhotoListCollectionViewCell.h"

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
}

- (void)setUpUI{
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    float collectionWidth = (SCREEN_WIDTH - 4 * 10)/3;
    layout.itemSize = CGSizeMake(collectionWidth, collectionWidth);
    
    //设置每一行之间的间距
    CGFloat inset = (SCREEN_WIDTH - 3 * layout.itemSize.width) / (3 + 1) - 1;
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
    
    //注册Cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SXPhotoListCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:SXPhotoListCollectionViewCellID];
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

#pragma mark -UICollectionViewDelegate/UICollectionViewDataSource-
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SXPhotoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SXPhotoListCollectionViewCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath.item:%ld",indexPath.item);
}

@end
