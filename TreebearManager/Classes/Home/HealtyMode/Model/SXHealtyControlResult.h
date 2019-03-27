//
//  SXHealtyControlResult.h
//  TreebearManager
//
//  Created by bear on 2019/3/27.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"
#import "SXHealtyControlModel.h"

@interface SXHealtyControlResult : SXBaseModel

///节点
@property (nonatomic, copy) NSString *nodeId;
///开关
@property (nonatomic, copy) NSNumber *op;
///创建时间
@property (nonatomic, copy) NSString *createTime;
///更新时间
@property (nonatomic, copy) NSString *updateTime;
///是否删除
@property (nonatomic, copy) NSString *isDelete;
///数组
@property (nonatomic, strong) SXHealtyControlModel *wifi;

@end

