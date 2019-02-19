//
//  SXLoginCertifyCodeButton.h
//  TreebearManager
//
//  Created by bear on 2019/2/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXLoginCertifyCodeButton : UIButton

@property (nonatomic ,assign) int timeOut; //设置超时时间

@property (nonatomic ,assign) BOOL isCounting; //倒计时进行中

- (void)start;//倒计时

@end

NS_ASSUME_NONNULL_END
