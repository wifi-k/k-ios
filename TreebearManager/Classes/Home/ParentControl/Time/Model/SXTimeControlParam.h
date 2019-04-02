//
//  SXTimeControlParam.h
//  TreebearManager
//
//  Created by bear on 2019/4/2.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

@interface SXTimeControlParam : SXBaseParam

///节点ID
@property (nonatomic, copy) NSString *nodeId;
///配置id，0时表示新增, 大于0表示修改
@property (nonatomic, copy) NSString *modelId;
///配置名称
@property (nonatomic, copy) NSString *name;
///开始时间
@property (nonatomic, copy) NSString *st;
///结束时间
@property (nonatomic, copy) NSString *et;
///周几
@property (nonatomic, assign) NSNumber *wt;
///mac列表,json字符串列表
@property (nonatomic, copy) NSString *mac;

@end
