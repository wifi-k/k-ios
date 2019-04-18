//
//  SXMobileManagerModel.h
//  TreebearManager
//
//  Created by bear on 2019/4/1.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXMobileManagerModel : SXBaseModel

///节点号
@property (nonatomic, copy) NSString *nodeId;
///Mac地址
@property (nonatomic, copy) NSString *mac;
///icon地址
@property (nonatomic, copy) NSString *macIcon;
///品牌商
@property (nonatomic, copy) NSString *macVendor;
///主机名
@property (nonatomic, copy) NSString *name;
///最近上线时间戳
@property (nonatomic, copy) NSString *onTime;
///最近离线时间戳
@property (nonatomic, copy) NSString *offTime;
///设备备注名
@property (nonatomic, copy) NSString *note;
///0-离线 or 1-在线
@property (nonatomic, copy) NSNumber *status;
///0-allow or 1-block
@property (nonatomic, copy) NSNumber *isBlock;
///0-关闭 or 1-上线提醒
@property (nonatomic, copy) NSNumber *isOnline;
///0-关闭 or 1-开启时间记录, 比如儿童关爱
@property (nonatomic, copy) NSNumber *isRecord;
///是否删除
@property (nonatomic, copy) NSNumber *isDelete;

@end
