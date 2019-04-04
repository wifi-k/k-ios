//
//  SXHomeReportNetTool.h
//  TreebearManager
//
//  Created by bear on 2019/4/4.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SXHomeReportPageParam.h"
#import "SXHomeReportResult.h"

@interface SXHomeReportNetTool : NSObject

///获取设备一周上网时长
+ (void)userNodeDeviceWeekListParams:(NSDictionary *)params Success:(void (^)(SXHomeReportResult *result))success failure:(void (^)(NSError *error))failure;

@end

