//
//  SXHealtyControlResult.h
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlResult : SXBaseModel

///节点
@property (nonatomic, copy) NSString *nodeId;
///开关
@property (nonatomic, copy) NSString *op;
///数组
@property (nonatomic, copy) id wifi;

@end

NS_ASSUME_NONNULL_END
