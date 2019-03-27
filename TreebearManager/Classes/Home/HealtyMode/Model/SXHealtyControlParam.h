//
//  SXHealtyControlParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlParam : SXBaseParam

///节点
@property (nonatomic, copy) NSString *nodeId;
///开关 1-开启 0-关闭
@property (nonatomic, copy) NSNumber *op;
///不传时表示无任何任何配置 此时op=0
@property (nonatomic, copy) NSString *wifi;

@end

NS_ASSUME_NONNULL_END
