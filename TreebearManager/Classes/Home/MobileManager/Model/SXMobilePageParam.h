//
//  SXMobilePageParam.h
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBasePageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXMobilePageParam : SXBasePageParam

///节点号
@property (nonatomic, copy) NSString *nodeId;
///Mac地址
@property (nonatomic, copy) NSString *mac;
///备注名
@property (nonatomic, copy) NSString *note;
///0-allow or 1-block
@property (nonatomic, copy) NSNumber *isBlock;
///0-不开启 or 1-开启时间记录, 比如儿童关爱
@property (nonatomic, copy) NSNumber *isRecord;

@end

NS_ASSUME_NONNULL_END
