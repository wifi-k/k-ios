//
//  SXPreventModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/28.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXPreventModel : SXBaseModel

///节点号
@property (nonatomic, copy) NSString *nodeId;
///Mac地址
@property (nonatomic, copy) NSString *mac;
///主机名
@property (nonatomic, copy) NSString *name;
///最近在线时间戳
@property (nonatomic, copy) NSString *onTime;
///最近离线时间戳
@property (nonatomic, copy) NSString *offTime;
///设备备注名
@property (nonatomic, copy) NSString *note;
///0-在线 or 1-离线
@property (nonatomic, copy) NSNumber *status;
///0-allow or 1-block
@property (nonatomic, copy) NSNumber *block;

@end

