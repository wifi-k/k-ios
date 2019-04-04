//
//  SXHomeReportModel.h
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXHomeReportModel : SXBaseModel

///nodeId
@property (nonatomic, copy) NSString *nodeId;
///2019, 默认今年
@property (nonatomic, copy) NSNumber *year;
///week_of_year,一年的第几周, 默认上一周
@property (nonatomic, copy) NSNumber *week;
///mac
@property (nonatomic, copy) NSString *mac;
///一周上网时长ms
@property (nonatomic, copy) NSString *totalTime;
///描述文案
@property (nonatomic, copy) NSString *remark;
///mac备注
@property (nonatomic, copy) NSString *macNote;
///设备名称
@property (nonatomic, copy) NSString *hostName;
///机型
@property (nonatomic, copy) NSString *macVendor;
///手机图片
@property (nonatomic, copy) NSString *macIcon;

@end

NS_ASSUME_NONNULL_END
