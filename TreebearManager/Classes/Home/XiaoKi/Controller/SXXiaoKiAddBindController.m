//
//  SXXiaoKiAddBindController.m
//  TreebearManager
//
//  Created by bear on 2019/3/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiAddBindController.h"
#import "SXXiaoKInfoModel.h"
#import "SXMineNetTool.h"

@interface SXXiaoKiAddBindController ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@end

@implementation SXXiaoKiAddBindController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpUI];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"小K添加";
    
    self.titleL.textColor = SXColor666666;
    
    [self.bindBtn roundViewWithRadius:6.0f];
}

#pragma mark -绑定小K-
- (void)userNodeBindData{
    //更新wan信息
    WS(weakSelf);
    SXXiaoKInfoModel *shareInfo = [SXXiaoKInfoModel sharedSXXiaoKInfoModel];
    if ([NSString isEmpty:shareInfo.modelId]) {
        [MBProgressHUD showWarningWithMessage:@"没有获取到节点，请检查系统网络设置!" toView:SXKeyWindow];
        return;
    }
    [MBProgressHUD showWhiteLoadingWithMessage:@"绑定中..." toView:SXKeyWindow];
    [SXMineNetTool userNodeBindParams:shareInfo.modelId Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        //提示
        [MBProgressHUD showSuccessWithMessage:@"绑定成功!" toView:SXKeyWindow];
        
        if (weakSelf.addBindSuccessBlock) {
            weakSelf.addBindSuccessBlock();
        }
        
        //通知绑定成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        NSString *message = [error.userInfo objectForKey:@"msg"];
        [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
    }];
}

#pragma mark -Event-
- (IBAction)clickBindBtn:(UIButton *)sender {
    [self userNodeBindData];
}

@end
