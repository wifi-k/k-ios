//
//  UIViewController+Placeholder.m
//  TreebearManager
//
//  Created by treebear on 2019/1/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "UIViewController+Placeholder.h"

@implementation UIViewController (Placeholder)

- (void)showTipsViewWithTopImageName:(NSString *)imageName content:(NSString *)content  btnText:(NSString *)btnText btnBlock:(void (^)(void))btnBlock{
    
    SXEmptyDataEventView *tipsView = [self.view viewWithTag:NSIntegerMax];
    if (tipsView == nil) {
        //1.创建无网络视图
        tipsView = [SXEmptyDataEventView tipsViewWithTopImageName:imageName content:content btnText:btnText btnBlock:btnBlock];
        tipsView.tag = NSIntegerMax;
        [self.view addSubview:tipsView];
        
        //2.居中显示
        [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(310);
            make.center.mas_equalTo(self.view);
        }];
    }
}
    
- (void)hideTipsView{
    UIView *tipsView = [self.view viewWithTag:NSIntegerMax];
    if (tipsView) {
        [tipsView removeFromSuperview];
    }
}
    
@end
