//
//  SXXiaoKInfoModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/20.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXXiaoKInfoModel : NSObject

SingletonInterface(SXXiaoKInfoModel)

///id
@property (nonatomic, copy) NSString *modelId;

///IP地址
@property (nonatomic, copy) NSString *ip;
///子网掩码
@property (nonatomic, copy) NSString *netmask;
///网关
@property (nonatomic, copy) NSString *gateway;
///dns1
@property (nonatomic, copy) NSString *dns1;
///dns2
@property (nonatomic, copy) NSString *dns2;
///1-pppoe 2-static 3-dynamic
@property (nonatomic, copy) NSNumber *type;
///pppoe账号
@property (nonatomic, copy) NSString *name;
///账号密码
@property (nonatomic, copy) NSString *passwd;

@end

NS_ASSUME_NONNULL_END
