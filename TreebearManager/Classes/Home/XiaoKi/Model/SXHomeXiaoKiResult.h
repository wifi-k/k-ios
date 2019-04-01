//
//  SXHomeXiaoKiResult.h
//  TreebearManager
//
//  Created by bear on 2019/3/29.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXHomeXiaoKiModel.h"

@interface SXHomeXiaoKiResult : SXBaseModel

///总数
@property (nonatomic, copy) NSNumber *total;
///分页数组
@property (nonatomic, copy) NSArray *page;

@end
