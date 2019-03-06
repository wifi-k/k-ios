//
//  SXNetBroadbandParam.h
//  TreebearManager
//
//  Created by bear on 2019/3/6.
//  Copyright © 2019 treebear. All rights reserved.
//

#import "SXBaseParam.h"

@interface SXNetBroadbandParam : SXBaseParam

///初始用户名, admin
@property (nonatomic, copy) NSString *name;
///初始密码,app端md5(123456)-e10adc3949ba59abbe56e057f20f883e,wifi端md5(app+xiaok)
@property (nonatomic, copy) NSString *passwd;

@end
