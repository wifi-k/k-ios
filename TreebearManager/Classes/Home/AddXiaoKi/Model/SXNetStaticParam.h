//
//  SXNetStaticParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/6.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

@interface SXNetStaticParam : SXBaseParam
///ip地址
@property (nonatomic, copy) NSString *ip;
///子网掩码
@property (nonatomic, copy) NSString *netmask;
///网关
@property (nonatomic, copy) NSString *gateway;
///首选DNS服务器
@property (nonatomic, copy) NSString *dns1;
///备用DNS服务器
@property (nonatomic, copy) NSString *dns2;

@end
