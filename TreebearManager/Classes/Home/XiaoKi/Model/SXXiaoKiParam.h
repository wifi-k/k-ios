//
//  SXXiaoKiParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBasePageParam.h"

@interface SXXiaoKiParam : SXBasePageParam

///nodeId不传或为空字符串时,查所有
@property (nonatomic, copy) NSString *nodeId;
///0：ALL 1：2.4G,2：5G  req=0时,表示更新节点下所有的ssid或passwd
@property (nonatomic, copy) NSNumber *freq;
///0-offline 1-normal 2-warn 3-error,status不传或为空时忽略这个条件
@property (nonatomic, copy) NSNumber *status;
///名称
@property (nonatomic, copy) NSString *name;
///新的ssid名称
@property (nonatomic, copy) NSString *ssid;
///新的md5密码
@property (nonatomic, copy) NSString *passwd;
///信号强度, [0,-100]dbm,好>=-50,强>=-70,中<-70,差<-80
@property (nonatomic, copy) NSNumber *rssi;

@end

