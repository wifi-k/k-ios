//
//  SXHealtyControlModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

@interface SXHealtyControlTimeModel : SXBaseModel

///开始时间
@property (nonatomic, copy) NSString *startTime;
///结束时间
@property (nonatomic, copy) NSString *endTime;

@end

@interface SXHealtyControlModel : SXBaseModel

///0-所有
@property (nonatomic, copy) NSNumber *freq;
///5-默认
@property (nonatomic, copy) NSNumber *rssi;
///数组
@property (nonatomic, copy) NSArray *timer;

@end
