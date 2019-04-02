//
//  SXForbiddenAppModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/5.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXForbiddenAppModel : NSObject

@property (nonatomic, copy) NSNumber *row;

//----//----
//----//----
///id
@property (nonatomic, copy) NSString *modelId;
///节点id
@property (nonatomic, copy) NSString *nodeId;
///配置名称
@property (nonatomic, copy) NSString *name;
///开始时间
@property (nonatomic, copy) NSString *st;
///结束时间
@property (nonatomic, copy) NSString *et;
///周几
@property (nonatomic, copy) NSString *wt;
///mac列表,json字符串列表
@property (nonatomic, copy) NSString *mac;
///开关
@property (nonatomic, copy) NSString *op;

@end

NS_ASSUME_NONNULL_END
