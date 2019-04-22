//
//  SXFamilyMemberModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXFamilyMemberModel : SXBaseModel

///id
@property (nonatomic, copy) NSString *userId;
///userName
@property (nonatomic, copy) NSString *userName;
///userMobile
@property (nonatomic, copy) NSString *userMobile;
///userAvatar
@property (nonatomic, copy) NSString *userAvatar;
///nodeId
@property (nonatomic, copy) NSString *nodeId;
///nodeName
@property (nonatomic, copy) NSString *nodeName;
///role role定义0-超级管理员
@property (nonatomic, copy) NSNumber *role;

///时候显示删除按钮
@property (nonatomic, assign) BOOL isShow;

@end

NS_ASSUME_NONNULL_END
