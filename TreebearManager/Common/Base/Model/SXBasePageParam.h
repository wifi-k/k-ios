//
//  SXBasePageParam.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXBasePageParam : SXBaseParam

///分页参数，分页号,默认1
@property (nonatomic, copy) NSNumber *pageNo;
///分页参数，一页的数据,默认10,最多100
@property (nonatomic, copy) NSNumber *pageSize;
///总数
@property (nonatomic, copy) NSNumber *totalCount;

@end

NS_ASSUME_NONNULL_END
