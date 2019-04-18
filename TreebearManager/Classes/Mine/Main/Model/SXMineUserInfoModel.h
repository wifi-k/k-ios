//
//  SXMineUserInfoModel.h
//  TreebearManager
//
//  Created by bear on 2019/2/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXMineUserInfoModel : SXBaseModel

/**
 * id
 */
@property (nonatomic, copy) NSString *modelId;
/**
 * 用户名
 */
@property (nonatomic, copy) NSString *name;
/**
 * passwd
 */
@property (nonatomic, copy) NSString *passwd;
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
 * 邀请码
 */
@property (nonatomic, copy) NSString *inviteCode;
/**
 * 认证状态 0-未认证 1-认证通过
 */
@property (nonatomic, copy) NSNumber *authStatus;
/**
 * role 用户角色 0管理员 其他成员
 */
@property (nonatomic, copy) NSNumber *role;
/**
 * 性别
 */
@property (nonatomic, copy) NSNumber *sex;
/**
 * 是否删除
 */
@property (nonatomic, copy) NSNumber *isDelete;
/**
 * 创建时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 * 修改时间
 */
@property (nonatomic, copy) NSString *updateTime;

@end

