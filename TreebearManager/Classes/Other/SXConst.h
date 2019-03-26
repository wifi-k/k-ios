//
//  SXConst.h
//  TreebearManager
//
//  Created by treebear on 2019/1/22.
//  Copyright © 2019 treebear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXConst : NSObject

//首页消息通知
extern NSString *const SXHomeMessageName;

//URL统一资源定位符
extern NSString *const user_vcode_getv2;
extern NSString *const user_signup_vcode;
extern NSString *const user_signin_vcode;
extern NSString *const user_signup_passwd;
extern NSString *const user_passwd_forget;

extern NSString *const user_passwd_reset;
extern NSString *const user_signin_passwd;
extern NSString *const user_info_get;

//xiaoki联网登录
extern NSString *const app_login;
extern NSString *const pppoe_set;
extern NSString *const static_set;
extern NSString *const dynamic_set;
extern NSString *const network_status;

extern NSString *const ssid_set;
extern NSString *const node_get;
extern NSString *const node_restart;
extern NSString *const node_reset;
extern NSString *const user_qiniu_get;

extern NSString *const user_info_set;
extern NSString *const user_node_firmware_upgrade;
extern NSString *const user_node_ssid_list;
extern NSString *const user_node_ssid_set;
extern NSString *const user_node_bind;

extern NSString *const user_node_unbind;
extern NSString *const user_node_list;
extern NSString *const user_node_info_set;
extern NSString *const user_info_getext;
extern NSString *const user_node_family_join;

extern NSString *const user_node_family_set;
extern NSString *const user_node_family_quit;
extern NSString *const user_node_family_list;
extern NSString *const user_node_share_join;
extern NSString *const user_node_share_quit;

@end

NS_ASSUME_NONNULL_END
