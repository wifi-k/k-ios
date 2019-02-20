//
//  SXLoginParam.h
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXLoginParam : SXBaseParam

/**
 * 1-注册，2-忘记密码,3-修改手机号,4-快捷登录
 */
@property (nonatomic, copy) NSNumber *type;
/**
 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 验证码
 */
@property (nonatomic, copy) NSString *vcode;
/**
 密码
 */
@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
