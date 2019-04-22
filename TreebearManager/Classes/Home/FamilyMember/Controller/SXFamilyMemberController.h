//
//  SXFamilyMemberController.h
//  TreebearManager
//
//  Created by bear on 2019/2/26.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseCustomTableViewPlainController.h"
#import "SXFamilyMemberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXFamilyMemberController : SXBaseCustomTableViewPlainController
///家庭管理员|成员模型 判断标志
@property (nonatomic, assign) BOOL isManager;

@end

NS_ASSUME_NONNULL_END
