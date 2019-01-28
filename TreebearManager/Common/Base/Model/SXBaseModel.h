//
//  SXBaseModel.h
//  TreebearManager
//
//  Created by treebear on 2019/1/25.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXBaseModel : SXBaseParam

@property (nonatomic, copy) NSNumber *pageNo;//分页参数，第几页：默认1
@property (nonatomic, copy) NSNumber *pageSize;//分页参数，一页多少条数据：默认20
@property (nonatomic, copy) NSNumber *totalCount;//总数

@end

NS_ASSUME_NONNULL_END
