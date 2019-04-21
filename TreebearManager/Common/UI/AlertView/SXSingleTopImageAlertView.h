//
//  SXSingleTopImageAlertView.h
//  TreebearManager
//
//  Created by bear on 2019/4/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXSingleTopImageAlertView : UIView

//设置遮罩蒙板响应事件是否关闭
@property (nonatomic, assign) BOOL closeUserInteractionEnabled;

@property (nonatomic,copy) void(^confirmButtonBlock)(void);

//初始化
+ (instancetype)alertWithTopImageName:(NSString *)imageName Title:(NSString *)title content:(NSString *)content confirmStr:(NSString *)confirmStr;

//弹窗
- (void)alert;

@end

NS_ASSUME_NONNULL_END
