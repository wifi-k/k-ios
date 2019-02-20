//
//  SXRegistParam.h
//  TreebearManager
//
//  Created by bear on 2019/2/19.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXLoginParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXRegistParam : SXLoginParam
/**
 再次输入密码
 */
@property (nonatomic, copy) NSString *passwd2;

@end

NS_ASSUME_NONNULL_END
