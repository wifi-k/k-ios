//
//  SXMineUserInfoModel.h
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineUserInfoModel : SXBaseModel
/**
 * 用户名
 */
@property (nonatomic, copy) NSString *name;
/**
 * 头像
 */
@property (nonatomic, copy) NSString *avatar;
/**
 * 手机号
 */
@property (nonatomic, copy) NSString *mobile;
/**
 * 邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 * 认证状态 0-未认证 1-认证通过
 */
@property (nonatomic, copy) NSNumber *authStatus;

@end

NS_ASSUME_NONNULL_END
