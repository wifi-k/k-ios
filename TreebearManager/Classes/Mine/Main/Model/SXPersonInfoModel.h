//
//  SXPersonInfoModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/21.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXMineUserInfoResult.h"

@interface SXPersonInfoModel : SXBaseModel

SingletonInterface(SXPersonInfoModel)

/**
 * 七牛token
 */
@property (nonatomic, copy) NSString *qnToken;

/**
 * 个人中心用户信息
 */
@property (nonatomic, strong) SXMineUserInfoResult *result;

@end
