//
//  SXMineUserInfoParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMineUserInfoParam : SXBaseParam

/**
 * 用户名
 */
@property (nonatomic, copy) NSString *name;
/**
 * 头像
 */
@property (nonatomic, copy) NSString *avatar;

@end

NS_ASSUME_NONNULL_END
