//
//  SXFamilyMemberParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXFamilyMemberParam : SXBaseParam

///节点的邀请码
@property (nonatomic, copy) NSString *inviteCode;
///节点
@property (nonatomic, copy) NSString *nodeId;
///删除的成员ID
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
