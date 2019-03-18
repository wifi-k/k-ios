//
//  SXHealtyControlModel.h
//  TreebearManager
//
//  Created by bear on 2019/3/18.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHealtyControlModel : SXBaseModel

///开始时间
@property (nonatomic, copy) NSString *startTime;
///结束时间
@property (nonatomic, copy) NSString *endTime;

@end

NS_ASSUME_NONNULL_END
