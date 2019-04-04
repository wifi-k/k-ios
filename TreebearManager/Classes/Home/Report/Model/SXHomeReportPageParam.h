//
//  SXHomeReportPageParam.h
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBasePageParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeReportPageParam : SXBasePageParam

///nodeId
@property (nonatomic, copy) NSString *nodeId;
///2019, 默认今年
@property (nonatomic, copy) NSNumber *year;
///week_of_year,一年的第几周, 默认上一周
@property (nonatomic, copy) NSNumber *week;

@end

NS_ASSUME_NONNULL_END
