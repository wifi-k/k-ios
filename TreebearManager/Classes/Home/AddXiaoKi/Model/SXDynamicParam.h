//
//  SXDynamicParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/6.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface SXDynamicParam : SXBaseParam

///ssid
@property (nonatomic, copy) NSString *ssid;
///app端md5(用户输入)，wifi端md5(app+xiaok)
@property (nonatomic, copy) NSString *passwd;

@end

NS_ASSUME_NONNULL_END
