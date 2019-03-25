//
//  SXMineUserInfoResult.h
//  TreebearManager
//
//  Created by bear on 2019/3/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXMineUserInfoModel.h"

@interface SXMineUserInfoResult : SXBaseModel

/**
 * 节点个数
 */
@property (nonatomic, copy) NSNumber *nodeSize;

/**
 * 个人信息
 */
@property (nonatomic, strong) SXMineUserInfoModel *user;

@end
