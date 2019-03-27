//
//  SXHomeXiaoKiModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXHomeXiaoKiModel : SXBaseModel

///节点id
@property (nonatomic, copy) NSString *nodeId;
///名称
@property (nonatomic, copy) NSString *name;
///当前固件版本
@property (nonatomic, copy) NSString *firmware;
///设备制造商
@property (nonatomic, copy) NSString *manufactory;
///型号
@property (nonatomic, copy) NSString *model;
///0-offline 1-normal 2-warn 3-error,status不传或为空时忽略这个条件
@property (nonatomic, copy) NSNumber *status;
///绑定时间
@property (nonatomic, copy) NSString *bindTime;
///:1-加入共享
@property (nonatomic, copy) NSNumber *isShare;
///是否选中
@property (nonatomic, copy) NSNumber *isSelect;
///固件升级版本号 firmwareUpgrade可能为空
@property (nonatomic, copy) NSString *firmwareUpgrade;

@end

