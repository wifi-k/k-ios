//
//  SXPhotoBrowserController.m
//  TreebearManager
//
//  Created by bear on 2019/4/8.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXPhotoBrowserController.h"
#import "SXPhotoBrowserBottomView.h"
#import "SXPhotoBrowserCell.h"

@interface SXPhotoBrowserController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
///底部视图
@property (nonatomic, weak) SXPhotoBrowserBottomView *bottomView;

///滚动视图
@property (nonatomic, weak) UICollectionView *collectionView;
///当前Cell
@property (nonatomic, strong) UICollectionViewCell *currentCell;
///当前索引
//@property (nonatomic, strong) NSIndexPath *currentIndexPath;
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
    
    self.navigationItem.title = @"图片浏览";
    
    //2.创建底部视图
    WS(weakSelf);
    SXPhotoBrowserBottomView *bottomView = [SXPhotoBrowserBottomView bottomView];
    bottomView.clickOptionBtnBlock = ^(NSInteger tag) {
        switch (tag) {
            case 0:
                DLog(@"tag:%ld",tag);
                break;
            case 1:{
                NSArray *indexPaths = [weakSelf.collectionView indexPathsForVisibleItems];
//                [weakSelf.collectionView deleteItemsAtIndexPaths:indexPaths];
                [weakSelf collectionView:weakSelf.collectionView didSelectItemAtIndexPath:indexPaths[0]];
            }
                break;
            case 2:
                DLog(@"tag:%ld",tag);
                break;
            default:
                break;
        }
    };
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    //流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - iPhoneX_Add_Bottom - 50);
    layout.minimumInteritemSpacing = 0; //定义左右cell的最小间距
    layout.minimumLineSpacing = 0;//定义上下cell的最小间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
    
    //创建collectionView
    UICollectionView *collectV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectV.dataSource = self;
    collectV.delegate = self;
    collectV.pagingEnabled = YES;
    collectV.bounces = NO;
    collectV.showsVerticalScrollIndicator = NO;
    collectV.showsHorizontalScrollIndicator = NO;
    collectV.backgroundColor = UIColor.blackColor;
    [self.view addSubview:collectV];
    self.collectionView = collectV;
    
    PHAsset *asset = self.dataArray[self.indexPath.item];
    NSDate *date = asset.creationDate;
    NSDateFormatter *dateformatter  = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [dateformatter stringFromDate:date];
    self.navigationItem.title = dateString;
    
    [MBProgressHUD showGrayLoadingToView:SXKeyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
    });
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-iPhoneX_Add_Bottom);
        make.height.mas_equalTo(50);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
}

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
    SXPhotoBrowserCell *cell = [SXPhotoBrowserCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    PHAsset *asset = self.dataArray[indexPath.item];
    cell.asset = asset;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 删除模型数据
    [self.dataArray removeObjectAtIndex:indexPath.item];
    // 删UI(刷新UI)
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark -UIScrollViewDelegate 代理方法-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if(offset.x<=0){
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    NSUInteger index = round(offset.x / scrollView.frame.size.width);
    
    DLog(@"index:%lu",(unsigned long)index);
    
    PHAsset *asset = self.dataArray[index];
    NSDate *date = asset.creationDate;
    NSDateFormatter *dateformatter  = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [dateformatter stringFromDate:date];
    self.navigationItem.title = dateString;
}

@end
