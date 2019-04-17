//
//  SXTabBarController.m
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXTabBarController.h"
#import "SXNavigationController.h"
#import "SXHomeController.h"
#import "SXPhotoController.h"
#import "SXMineController.h"
#import "SXHomeMainController.h"

#import "UIImage+Extension.h"

@implementation SXTabBarController

//第一次使用这个类或者这个类的子类的时候
+ (void)initialize{
    if (self == [SXTabBarController class]) {//保证只调用一次
        //位置
        [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -1)];
        //Normal
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:SXColor4A5B78} forState:UIControlStateNormal];
        //Selected
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:SXColorBlue2} forState:UIControlStateSelected];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建tabBar
    self.tabBar.tintColor = SXColorBlue2;
    self.tabBar.barTintColor = SXColorWhite;
//    self.tabBar.unselectedItemTintColor = SXColor4A5B78;
    
    //2.添加子控制器
    [self setUpChildViewController];
}

//改变tabbar高度
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame;
//    tabFrame.size.height = 49;
//    tabFrame.origin.y = self.view.frame.size.height - 49;
//    self.tabBar.frame = tabFrame;
//}

- (void)setUpChildViewController{
    
    SXHomeController *homeVC = [[SXHomeController alloc] init];
    [self setUpChildController:homeVC image:[UIImage imageNamed:@"tab_home_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_home_selected"] title:@"首页"];
    
    SXPhotoController *memberVC = [[SXPhotoController alloc] init];
    [self setUpChildController:memberVC image:[UIImage imageNamed:@"tab_mine_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_mine_selected"] title:@"相册"];
    
    SXMineController *mineVC = [[SXMineController alloc] init];
    [self setUpChildController:mineVC image:[UIImage imageNamed:@"tab_photo_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_photo_selected"] title:@"我的"];
}

- (void)setUpChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title{
    
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.badgeValue = nil;
    
    vc.tabBarItem.selectedImage = selectImage;
    
    SXNavigationController *navi = [[SXNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
}

- (void)changeToMainHomeVC{
    SXHomeMainController *homeVC = [[SXHomeMainController alloc] init];
    [self changeWithHomeVC:homeVC];
}
    
- (void)changeToHomeVC{
    SXHomeController *homeVC = [[SXHomeController alloc] init];
    [self changeWithHomeVC:homeVC];
}

- (void)changeWithHomeVC:(UIViewController *)homeVC{
    //创建首页
    homeVC.tabBarItem.title = @"首页";
    homeVC.tabBarItem.badgeValue = nil;
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tab_home_normal"];
    homeVC.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab_home_selected"];
    SXNavigationController *navi = [[SXNavigationController alloc] initWithRootViewController:homeVC];
    
    NSArray *child = self.childViewControllers;
    NSMutableArray *fdfd = [NSMutableArray arrayWithArray:child];
    [fdfd replaceObjectAtIndex:0 withObject:navi];
    self.viewControllers = fdfd;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
