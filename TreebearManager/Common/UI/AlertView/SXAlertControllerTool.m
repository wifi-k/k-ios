//
//  SXAlertControllerTool.m
//  TreebearManager
//
//  Created by bear on 2019/2/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXAlertControllerTool.h"
#import "SXRootTool.h"

@implementation SXAlertControllerTool

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirm:(void (^)(UIAlertAction *action))confirm cancel:(void (^)(UIAlertAction *action))cancel{
    //用户之前已经拒绝授权
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel(action);
        }
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm(action);
        }
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [SXRootTool.topViewController presentViewController:alertVC animated:YES completion:nil];
}

@end
