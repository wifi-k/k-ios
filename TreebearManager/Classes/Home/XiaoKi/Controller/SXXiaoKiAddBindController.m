//
//  SXXiaoKiAddBindController.m
//  TreebearManager
//
//  Created by bear on 2019/3/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXXiaoKiAddBindController.h"
#import "SXMineNetTool.h"
#import "SXAddXiaokiNetTool.h"
#import "XKGetWifiNetTool.h"
#import "SXNetReachablityTool.h"
#import "SXTitleAlertView.h"
#import "SXRootTool.h"

@interface SXXiaoKiAddBindController ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

//当前节点信息
@property (strong, nonatomic) SXXiaoKNodeResult *currentResult;
@end

@implementation SXXiaoKiAddBindController

#pragma mark -getter-
- (SXXiaoKNodeResult *)currentResult{
    if (_currentResult == nil) {
        _currentResult = [[SXXiaoKNodeResult alloc] init];
    }
    return _currentResult;
}

#pragma mark -life recycle-
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //1.获取当前连接wifi信息
    [self getWifiInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self addNotification];
}

- (void)addNotification{
    // app从后台进入前台都会调用这个方法
    [SXNotificationCenter addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)dealloc{
    [SXNotificationCenter removeObserver:self];
}

#pragma mark -事件监听-
- (void)applicationBecomeActive{
    //1.获取当前连接wifi信息
    [self getWifiInfo];
}

#pragma mark -初始化UI-
- (void)setUpUI{
    self.view.backgroundColor = SXColorWhite;
    
    self.navigationItem.title = @"小K添加";
    
    self.titleL.textColor = SXColor2B3852;
    
    [self.bindBtn setTitleColor:SXColorTextDisabled forState:UIControlStateDisabled];
    [self.bindBtn roundViewWithRadius:6.0f];
    self.bindBtn.enabled = NO;
}

#pragma mark -是否隐藏-
- (void)hideSubviews:(BOOL)isHidden{
    self.titleL.hidden = isHidden;
    self.bindBtn.hidden = isHidden;
}

#pragma mark -获取节点数据-
- (void)getNodeData{
    WS(weakSelf);
    self.bindBtn.enabled = NO;
    [SXAddXiaokiNetTool getNodeWithDataWithSuccess:^(SXXiaoKNodeResult * _Nonnull result) {
        DLog(@"获取节点:%@",result.modelId);
        weakSelf.bindBtn.enabled = YES;
        //更新wan信息
        weakSelf.currentResult = result;
    } failure:^(NSError * _Nonnull error) {
        weakSelf.bindBtn.enabled = YES;
        NSString *message = [error.userInfo objectForKey:@"msg"];
        if ([NSString isNotEmpty:message]) {
            [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
        }
    }];
}

#pragma mark -获取当前连接wifi信息-
- (void)getWifiInfo{
    NSString *wifiSSID = [XKGetWifiNetTool getWifiSSID];
    DLog(@"wifi:%@",wifiSSID);
    if (SXNetReachablityTool.status == SXNetworkStatusWifi) {
        self.titleL.text = [NSString stringWithFormat:@"您已连接wifi名称为'%@'的设备，前往配置网络",wifiSSID];
        [self hideSubviews:NO];
        //重新连接之后，更新节点信息
        [self getNodeData];
    } else{
        [self hideSubviews:YES];
        [self alertOnNetAlertView];
    }
}

#pragma mark -绑定小K-
- (void)userNodeBindData{
    //更新wan信息
    WS(weakSelf);
    if ([NSString isEmpty:self.currentResult.modelId]) {
        [self alertOnNetAlertView];
        return;
    }
    [MBProgressHUD showWhiteLoadingWithMessage:@"绑定中..." toView:SXKeyWindow];
    [SXMineNetTool userNodeBindParams:self.currentResult.modelId Success:^{
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        
        if (weakSelf.addBindSuccessBlock) {
            weakSelf.addBindSuccessBlock();
        }
        
        //通知绑定成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //提示
            [MBProgressHUD showSuccessWithMessage:@"绑定成功!" toView:SXKeyWindow];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:SXKeyWindow animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *message = [error.userInfo objectForKey:@"msg"];
            if (error.code == 8) {
                message = @"设备已经被绑定!";
            }
            if ([NSString isNotEmpty:message]) {
                [MBProgressHUD showFailWithMessage:message toView:SXKeyWindow];
            }
        });
    }];
}

#pragma mark -视图弹窗-
- (void)alertOnNetAlertView{
    
    BOOL isContainsAlert = NO;
    for (UIView *v in SXDelegateWindow.subviews) {
        if ([v isKindOfClass:SXTitleAlertView.class]) {
            isContainsAlert = YES;
            break;
        }
    }
    
    if (!isContainsAlert) {
        
        SXTitleAlertView *netAlertView = [SXTitleAlertView alertWithTitle:@"连网提示" content:@"请立即连接wifi名称为'xiaok-xxxx'并配置网络" confirmStr:@"确定" cancelStr:@"取消"];
        netAlertView.confirmButtonBlock = ^{
            [SXRootTool jumpToSystemWIFI];
        };
        netAlertView.cancelButtonBlock = ^{
            
        };
        [netAlertView alert];
    }
}

#pragma mark -Event-
- (IBAction)clickBindBtn:(UIButton *)sender {
    [self userNodeBindData];
}

@end
