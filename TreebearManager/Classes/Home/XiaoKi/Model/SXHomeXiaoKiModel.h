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
///节点freq
@property (nonatomic, copy) NSString *freq;
///ssid
@property (nonatomic, copy) NSString *ssid;
///passwd
@property (nonatomic, copy) NSString *passwd;
///信号
@property (nonatomic, copy) NSString *rssi;

@end

