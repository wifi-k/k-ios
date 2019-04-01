//
//  SXMobileManagerResult.h
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXMobileManagerModel.h"

@interface SXMobileManagerResult : SXBaseModel

///总数
@property (nonatomic, copy) NSNumber *total;
///分页数组
@property (nonatomic, copy) NSArray *page;

@end
