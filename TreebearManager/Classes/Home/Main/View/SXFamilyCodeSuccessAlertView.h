//
//  SXFamilyCodeSuccessAlertView.h
//  TreebearManager
//
//  Created by bear on 2019/2/15.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXFamilyCodeSuccessAlertView : UIView

//设置遮罩蒙板响应事件是否关闭
@property (nonatomic, assign) BOOL closeUserInteractionEnabled;

@property (nonatomic,copy) void(^confirmButtonBlock)(void);

//初始化
+ (instancetype)alertWithTopImageName:(NSString *)imageName title:(NSString *)title content:(NSString *)content confirmStr:(NSString *)confirmStr;

//弹窗
- (void)alert;

@end
