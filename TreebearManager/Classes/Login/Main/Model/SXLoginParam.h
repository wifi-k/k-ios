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
 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 验证码
 */
@property (nonatomic, copy) NSString *code;
/**
 密码
 */
@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
