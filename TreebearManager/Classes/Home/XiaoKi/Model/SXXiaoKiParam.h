//
//  SXXiaoKiParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBasePageParam.h"

@interface SXXiaoKiParam : SXBasePageParam

///nodeId不传或为空字符串时,查所有
@property (nonatomic, copy) NSString *nodeId;
///0-offline 1-normal 2-warn 3-error,status不传或为空时忽略这个条件
@property (nonatomic, copy) NSNumber *status;

@end

