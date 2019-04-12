//
//  SXOnlineController.m
//  TreebearManager
//
//  Created by bear on 2019/3/7.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXOnlineController.h"
#import "SXOnlineAutotIPController.h"
#import "SXOnlineFixedIPController.h"
#import "SXOnlineBroadbandController.h"
#import "SXOnlineOptionHeaderView.h"
#import "SXDropDownMenu.h"

@interface SXOnlineController ()<SXDropDownMenuDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
///头部视图
@property (nonatomic, weak) SXOnlineOptionHeaderView *headerView;
///下拉菜单
@property (nonatomic, weak) SXDropDownMenu *dropDownMenu;

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *titles;//分类标题数组
@property (nonatomic, strong) NSArray *controllers;//子控制器容器
@end

@implementation SXOnlineController

#pragma mark -getter方法-
/**
 *  创建分类标题数组
 */
- (NSMutableArray *)titles {
    if(!_titles) {
        NSArray *array = @[@"自动获取IP地址",@"固定IP地址",@"宽带拨号上网"];
        _titles = [NSMutableArray arrayWithArray:array];
    }
    return _titles;
}

/**
 *  加载UIPageViewController
 */
- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                 options:nil];
        [pageViewController willMoveToParentViewController:self];
        pageViewController.delegate = self;
        //pageViewController.dataSource = self;
        [self addChildViewController:pageViewController];
        [self.view addSubview:pageViewController.view];
        [pageViewController setViewControllers:@[self.controllers.firstObject]
                                     direction:UIPageViewControllerNavigationDirectionForward
                                      animated:YES
                                    completion:nil];
        [pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_bottom).mas_offset(60);
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        _pageViewController = pageViewController;
    }
    return _pageViewController;
}

/**
 *  加载子控制器
 */
- (NSArray *)controllers {
    if(!_controllers) {
        _controllers = @[[[SXOnlineAutotIPController alloc] init],
                         [[SXOnlineFixedIPController alloc] init],
                         [[SXOnlineBroadbandController alloc] init]];
    }
    return _controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"上网设置";
    
    WS(weakSelf);
    SXOnlineOptionHeaderView *headerView = [SXOnlineOptionHeaderView headerView];
    headerView.clickOptionBtnBlock = ^(BOOL isSelected) {
        DLog(@"菜单。。。");
        if (isSelected) {
            [weakSelf setUpDropDownMenu];
        } else{
            [weakSelf.dropDownMenu hideDropDownMenuWithBtnFrame:weakSelf.headerView.optionBtn.frame];
        }
    };
    [self.view addSubview:headerView];
    self.headerView = headerView;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

#pragma mark -下拉菜单视图-
- (void)setUpDropDownMenu{
    SXDropDownMenu *dropDownMenu = [SXDropDownMenu dropMenu];
    [dropDownMenu showDropDownMenuWithButtonFrame:self.headerView.optionBtn.frame titles:self.titles];
    dropDownMenu.delegate = self;
    [self.view addSubview:dropDownMenu];
    self.dropDownMenu = dropDownMenu;
}

#pragma mark -SXDropDownMenuDelegate-
- (void)popDropMenu:(SXDropDownMenu *)popView row:(NSInteger)row{
    DLog(@"row:%ld",row);
    self.headerView.optionStr = self.titles[row];
    
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:row]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    if (row ==  0) {
        SXOnlineAutotIPController *autoVC = [self.controllers objectAtIndex:row];
        [autoVC getNodeData];
    }
}

#pragma mark -UIPageViewControllerDelegate/UIPageViewControllerDelegate-
/**
 *  当前控制器的上一个控制器
 */
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    //写入选择的controller的筛选状态
    NSInteger index = [self indexForViewController:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}

/**
 *  当前控制器的下一个控制器
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    DLog(@"手势滑动分页...");
//    UIViewController *viewController = self.pageViewController.viewControllers[0];
//    NSUInteger index = [self indexForViewController:viewController];
//    [self.topTitleView trans2ShowAtIndex:index];
}

#pragma mark -private-
/**
 *  某一个控制器的index
 */
- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}

@end
