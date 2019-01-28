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

#import "UIImage+Extension.h"

@implementation SXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建tabBar
    self.tabBar.tintColor = UIColor.blackColor;
    //2.添加子控制器
    [self setUpChildViewController];
}

- (void)setUpChildViewController{
    
    SXHomeController *homeVC = [[SXHomeController alloc] init];
    [self setUpChildController:homeVC image:[UIImage imageNamed:@"tab_home_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_home_selected"] title:@"首页"];
    
    SXPhotoController *memberVC = [[SXPhotoController alloc] init];
    [self setUpChildController:memberVC image:[UIImage imageNamed:@"tab_order_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_order_selected"] title:@"相册"];
    
    SXMineController *mineVC = [[SXMineController alloc] init];
    [self setUpChildController:mineVC image:[UIImage imageNamed:@"tab_my_normal"] selectImage:[UIImage imageWithOriginalName:@"tab_my_selected"] title:@"我的"];
}

- (void)setUpChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title{
    
    vc.tabBarItem.title = title;
    
    vc.tabBarItem.image = image;
    
    vc.tabBarItem.badgeValue = nil;
    
    vc.tabBarItem.selectedImage = selectImage;
    
    SXNavigationController *navi = [[SXNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
