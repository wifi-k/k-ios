//
//  SXCodeInputAlertView.h
//  TreebearManager
//
//  Created by bear on 2019/2/14.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXCodeInputAlertView : UIView

//设置遮罩蒙板响应事件是否关闭
@property (nonatomic, assign) BOOL closeUserInteractionEnabled;

@property (nonatomic,copy) void(^confirmButtonBlock)(NSString *text);

@property (nonatomic,copy) void(^cancelButtonBlock)(void);

//初始化
+ (instancetype)alertWithTitle:(NSString *)title placeholder:(NSString *)placeholder confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr;

//弹窗
- (void)alert;

@end

NS_ASSUME_NONNULL_END
