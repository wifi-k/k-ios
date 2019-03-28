//
//  SXUserGuideController.m
//  TreebearManager
//
//  Created by bear on 2019/3/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXUserGuideController.h"
#import "SXRootTool.h"
#import "SXUserDefaultsTool.h"

@interface SXUserGuideController (){
    NSInteger index;
}
@property (weak, nonatomic) IBOutlet UIImageView *guideImageView;

///图片资源
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SXUserGuideController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark -控制器生命周期方法-
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置当前导航条背景色
    //    self.navigationController.navigationBar.barTintColor = SXColorBlue2;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //设置当前导航条背景色
    //    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -getter-
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int i=0; i<3; i++) {
            NSString *imageName = [NSString stringWithFormat:@"img_guide_%d",i+1];
            [_dataArray addObject:imageName];
        }
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI{
    self.guideImageView.userInteractionEnabled = YES;
//    self.guideImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //1.1添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBgView)];
    [self.guideImageView addGestureRecognizer:tap];
    
    //2.设置初始值
    index = 0;
}


- (void)clickBgView{
    ++index;
    if (self.dataArray.count > index) {
        NSString *imageName = self.dataArray[index];
        self.guideImageView.image = [UIImage imageNamed:imageName];
    } else {
        DLog(@"index:%ld",index);
        [SXUserDefaultsTool saveShowGuide:YES];
        [SXRootTool chooseRootWithTabBarVC:SXDelegateWindow];
    }
}

@end
